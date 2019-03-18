package net.syscon.elite.service.impl;

import lombok.extern.slf4j.Slf4j;
import net.syscon.elite.api.model.OffenderBooking;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.api.support.PageRequest;
import net.syscon.elite.repository.InmateRepository;
import net.syscon.elite.security.AuthenticationFacade;
import net.syscon.elite.service.BookingService;
import net.syscon.elite.service.SearchOffenderService;
import net.syscon.elite.service.UserService;
import net.syscon.elite.service.support.InmatesHelper;
import net.syscon.elite.service.support.SearchOffenderRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@Transactional(readOnly = true)
@Slf4j
public class SearchOffenderServiceImpl implements SearchOffenderService {
    private final BookingService bookingService;
    private final UserService userService;
    private final InmateRepository repository;
    private final AuthenticationFacade securityUtils;
    private final String locationTypeGranularity;
    private final Pattern offenderNoRegex;

    public SearchOffenderServiceImpl(final BookingService bookingService, final UserService userService, final InmateRepository repository, final AuthenticationFacade securityUtils,
                                     @Value("${api.users.me.locations.locationType:WING}") final String locationTypeGranularity,
                                     @Value("${api.offender.no.regex.pattern:^[A-Za-z]\\d{4}[A-Za-z]{2}$}") final String offenderNoRegex) {
        this.bookingService = bookingService;
        this.userService = userService;
        this.repository = repository;
        this.securityUtils = securityUtils;
        this.locationTypeGranularity = locationTypeGranularity;
        this.offenderNoRegex = Pattern.compile(offenderNoRegex);
    }

    @Override
    public Page<OffenderBooking> findOffenders(final SearchOffenderRequest request) {
        Objects.requireNonNull(request.getLocationPrefix(), "locationPrefix is a required parameter");
        final var keywordSearch = StringUtils.upperCase(StringUtils.trimToEmpty(request.getKeywords()));
        String offenderNo = null;
        String searchTerm1 = null;
        String searchTerm2 = null;

        log.info("Searching for offenders, criteria: {}", request);
        if (StringUtils.isNotBlank(keywordSearch)) {
            if (isOffenderNo(keywordSearch)) {
                offenderNo = keywordSearch;
            } else {
                final var nameSplit = StringUtils.split(keywordSearch, " ,");
                searchTerm1 = nameSplit[0];

                if (nameSplit.length > 1) {
                    searchTerm2 = nameSplit[1];
                }
            }
        }

        final PageRequest pageRequest;

        if (StringUtils.isBlank(request.getOrderBy())) {
            pageRequest = request.toBuilder().orderBy(DEFAULT_OFFENDER_SORT).build();
        } else {
            pageRequest = request;
        }

        final Set<String> caseloads = securityUtils.isOverrideRole() ? Set.of() : userService.getCaseLoadIds(request.getUsername());

        // TODO
        // The paged list of OffenderBookings will now contain the the convictedStatus 'Convicted', 'Remand', or 'Unknown'
        // Move the logic from the DB SQL to here - where the business rules should reside
        // WARNING: The OffenderBooking object is returned from multiple repository calls

        final var bookingsPage = repository.searchForOffenderBookings(
                caseloads, offenderNo, searchTerm1, searchTerm2,
                request.getLocationPrefix(),
                request.getAlerts(),
                locationTypeGranularity, pageRequest);

        final var bookings = bookingsPage.getItems();
        final var bookingIds = bookings.stream().map(OffenderBooking::getBookingId).collect(Collectors.toList());
        if (!CollectionUtils.isEmpty(bookingIds)) {
            if (request.isReturnIep()) {
                final var bookingIEPSummary = bookingService.getBookingIEPSummary(bookingIds, false);
                bookings.forEach(booking -> booking.setIepLevel(bookingIEPSummary.get(booking.getBookingId()).getIepLevel()));
            }
            if (request.isReturnAlerts()) {
                final var alertCodesForBookings = bookingService.getBookingAlertSummary(bookingIds, LocalDateTime.now());
                bookings.forEach(booking -> booking.setAlertsDetails(alertCodesForBookings.get(booking.getBookingId())));
            }
            if (request.isReturnCategory()) {
                final var assessmentsForBookings = repository.findAssessments(bookingIds, "CATEGORY", caseloads);
                InmatesHelper.setCategory(bookings, assessmentsForBookings);
            }
        }
        log.info("Found {} offenders, page size {}", bookingsPage.getTotalRecords(), bookingsPage.getItems().size());

        return bookingsPage;
    }

    private boolean isOffenderNo(final String potentialOffenderNumber) {
        final var m = offenderNoRegex.matcher(potentialOffenderNumber);
        return m.find();
    }
}
