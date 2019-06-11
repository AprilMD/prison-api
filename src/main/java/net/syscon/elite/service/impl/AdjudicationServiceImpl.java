package net.syscon.elite.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.val;
import net.syscon.elite.api.model.Agency;
import net.syscon.elite.api.model.Location;
import net.syscon.elite.api.model.adjudications.Adjudication;
import net.syscon.elite.api.model.adjudications.AdjudicationDetail;
import net.syscon.elite.api.model.adjudications.AdjudicationOffence;
import net.syscon.elite.api.model.adjudications.AdjudicationSummary;
import net.syscon.elite.api.model.adjudications.Award;
import net.syscon.elite.api.model.adjudications.Hearing;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.repository.AdjudicationsRepository;
import net.syscon.elite.repository.AgencyRepository;
import net.syscon.elite.repository.LocationRepository;
import net.syscon.elite.security.VerifyBookingAccess;
import net.syscon.elite.service.AdjudicationSearchCriteria;
import net.syscon.elite.service.AdjudicationService;
import net.syscon.elite.service.BookingService;
import net.syscon.elite.service.EntityNotFoundException;
import net.syscon.elite.service.support.LocationProcessor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.function.Function;

import static java.util.stream.Collectors.toList;
import static net.syscon.elite.repository.support.StatusFilter.ALL;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class AdjudicationServiceImpl implements AdjudicationService {

    private final AdjudicationsRepository repository;
    private final AgencyRepository agencyRepository;
    private final LocationRepository locationRepository;
    private final BookingService bookingService;

    @Value("${api.cutoff.adjudication.months:3}")
    private int adjudicationCutoffDefault;
    @Value("${api.cutoff.award.months:0}")
    private int awardCutoffDefault;

    @Override
    public AdjudicationDetail findAdjudication(final String offenderNo, final long adjudicationNo) {
        bookingService.verifyCanViewLatestBooking(offenderNo);
        return repository.findAdjudicationDetails(offenderNo, adjudicationNo)
                .map(this::enrich)
                .orElseThrow(EntityNotFoundException.withId(adjudicationNo));
    }

    private AdjudicationDetail enrich(final AdjudicationDetail detail) {

        val locationFinder = locationFinder();
        val establishmentFinder = establishmentFinder();

        val hearings = detail.getHearings().stream()
                .<Hearing>map(hearing -> {
                    val location = locationFinder.apply(hearing.getInternalLocationId());
                    val establishment = establishmentFinder.apply(location.getAgencyId());
                    return enrich(hearing, location, establishment);
                })
                .collect(toList());

        val location = locationFinder.apply(detail.getInternalLocationId());
        val establishment = establishmentFinder.apply(detail.getAgencyId());

        return detail.toBuilder()
                .clearHearings()
                .establishment(establishment)
                .interiorLocation(getInteriorLocationDescription(location))
                .hearings(hearings)
                .build();
    }


    private Hearing enrich(final Hearing hearing, final Location location, final String establishment) {

        return hearing.toBuilder()
                .establishment(establishment)
                .location(getInteriorLocationDescription(location))
                .build();
    }

    private Function<Long, Location> locationFinder() {
        val locations = new HashMap<Long, Location>();
        return locationId -> locations.computeIfAbsent(locationId, id ->
                locationRepository.findLocation(id, ALL)
                        .orElseThrow(EntityNotFoundException.withId(id)));
    }

    private Function<String, String> establishmentFinder() {
        val establishments = new HashMap<String, String>();
        return agencyId -> establishments.computeIfAbsent(agencyId, id ->
                agencyRepository.findAgency(id, ALL)
                        .map(agency -> LocationProcessor.formatLocation(agency.getDescription()))
                        .orElseThrow(EntityNotFoundException.withId(agencyId)));
    }

    private String getInteriorLocationDescription(final Location location) {
        val processedLocation = LocationProcessor.processLocation(location, true);
        return processedLocation.getDescription();
    }

    @Override
    public Page<Adjudication> findAdjudications(final AdjudicationSearchCriteria criteria) {
        bookingService.verifyCanViewLatestBooking(criteria.getOffenderNumber());
        return repository.findAdjudications(criteria);
    }

    @Override
    public List<AdjudicationOffence> findAdjudicationsOffences(final String offenderNo) {
        return repository.findAdjudicationOffences(offenderNo);
    }

    @Override
    public List<Agency> findAdjudicationAgencies(final String offenderNo) {
        return repository.findAdjudicationAgencies(offenderNo).stream()
                .map(agency -> agency.toBuilder()
                        .description(LocationProcessor.formatLocation(agency.getDescription()))
                        .build())
                .collect(toList());
    }

    /**
     * Get awards that have not expired, i.e. the end date is today or later, and
     * count proved adjudications which expired on or later than the from date.
     */
    @Override
    @VerifyBookingAccess(overrideRoles = {"SYSTEM_USER", "GLOBAL_SEARCH"})
    public AdjudicationSummary getAdjudicationSummary(final Long bookingId, final LocalDate awardCutoffDateParam,
                                                      final LocalDate adjudicationCutoffDateParam) {
        val list = repository.findAwards(bookingId);
        val today = LocalDate.now();
        var awardCutoffDate = awardCutoffDateParam;
        if (awardCutoffDate == null) {
            awardCutoffDate = today.plus(-awardCutoffDefault, ChronoUnit.MONTHS);
        }
        var adjudicationCutoffDate = adjudicationCutoffDateParam;
        if (adjudicationCutoffDate == null) {
            adjudicationCutoffDate = today.plus(-adjudicationCutoffDefault, ChronoUnit.MONTHS);
        }
        val iterator = list.iterator();
        var adjudicationCount = 0;
        Award previous = null;

        while (iterator.hasNext()) {
            val current = iterator.next();
            val endDate = calculateEndDate(current);

            if (!adjudicationCutoffDate.isAfter(endDate) && changed(previous, current)) {
                adjudicationCount++;
                previous = current;
            }
            if (awardCutoffDate.isAfter(endDate)) {
                iterator.remove();
            }
        }
        return AdjudicationSummary.builder().awards(list).adjudicationCount(adjudicationCount).build();
    }

    private LocalDate calculateEndDate(final Award award) {
        var endDate = award.getEffectiveDate();
        if (award.getMonths() != null) {
            endDate = endDate.plusMonths(award.getMonths());
        }
        if (award.getDays() != null) {
            endDate = endDate.plusDays(award.getDays());
        }
        return endDate;
    }

    private boolean changed(final Award previous, final Award current) {
        return previous == null || !Objects.equals(previous.getHearingId(), current.getHearingId());
        // Note we only consider the hearing id, not the sequence number as we only
        // expect at most one proved adjudication in the sequence list
    }
}
