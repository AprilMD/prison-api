package uk.gov.justice.hmpps.prison.api.resource.impl;

import org.junit.After;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.test.mock.mockito.SpyBean;
import org.springframework.context.annotation.Bean;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import uk.gov.justice.hmpps.prison.repository.jpa.repository.BedAssignmentHistoriesRepository;
import uk.gov.justice.hmpps.prison.repository.jpa.repository.OffenderBookingRepository;
import uk.gov.justice.hmpps.prison.service.BedAssignmentHistoryService;
import uk.gov.justice.hmpps.prison.util.JwtParameters;

import java.time.*;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static java.lang.String.format;
import static java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.doThrow;
import static org.springframework.http.HttpMethod.PUT;
import static org.springframework.http.HttpStatus.*;

@ContextConfiguration(classes = OffenderMovementsResourceImplIntTest_moveToCell.TestClock.class)
public class OffenderMovementsResourceImplIntTest_moveToCellSwap extends ResourceTest   {

    @TestConfiguration
    static class TestClock {
        @Bean
        public Clock clock() {
            return Clock.fixed(Instant.now(), ZoneId.systemDefault());
        }
    }

    @Autowired
    private OffenderBookingRepository offenderBookingRepository;
    @Autowired
    private BedAssignmentHistoriesRepository bedAssignmentHistoriesRepository;
    @Autowired
    private Clock clock;
    @SpyBean
    private BedAssignmentHistoryService bedAssignmentHistoryService;

    private static final Long BOOKING_ID = -33L;
    private static final String BOOKING_ID_S = "-33";

    private static final String INITIAL_CELL_DESC = "LEI-H-1-1";
    private static final String INITIAL_REASON = "ADM";
    private static final LocalDateTime INITIAL_DATE_TIME = LocalDateTime.of(2020, 4, 3, 11, 0, 0);

    private static final Long INITIAL_CELL = -15L;
    private static final Long NEW_CELL = 14538L;
    private static final String NEW_CELL_DESC = "LEI-CSWAP";


    @After
    public void tearDown() {
        // Return the offender back to his original cell as configured in the test data in R__3_6_1__OFFENDER_BOOKINGS.sql
        requestMoveToCell(validToken(), BOOKING_ID_S, INITIAL_CELL_DESC, INITIAL_REASON, INITIAL_DATE_TIME.format(ISO_LOCAL_DATE_TIME));
    }

    @Test
    public void validRequest() {
        final var dateTime = LocalDateTime.now().minusHours(1);

        final var response = requestMoveToCellSwap(validToken(), BOOKING_ID_S, "BEH", dateTime.format(ISO_LOCAL_DATE_TIME));

        verifySuccessResponse(response, BOOKING_ID, NEW_CELL, NEW_CELL_DESC);
        verifyOffenderBookingLivingUnit(BOOKING_ID, NEW_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, NEW_CELL, "BEH", dateTime);
    }

    @Test
    public void validRequest_withoutReasonCode_defaultsToAdm() {
        final var dateTime = LocalDateTime.now().minusHours(1);

        final var response = requestMoveToCellSwap(validToken(), BOOKING_ID_S, null, dateTime.format(ISO_LOCAL_DATE_TIME));

        verifySuccessResponse(response, BOOKING_ID, NEW_CELL, NEW_CELL_DESC);
        verifyOffenderBookingLivingUnit(BOOKING_ID, NEW_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, NEW_CELL, "ADM", dateTime);
    }

    @Test
    public void missingDate_defaultsToNow() {
        final var expectedDateTime = clock.instant().atZone(ZoneId.systemDefault()).toLocalDateTime();

        final var response = requestMoveToCell(validToken(), BOOKING_ID_S, NEW_CELL_DESC, "BEH", "");

        verifySuccessResponse(response, BOOKING_ID, NEW_CELL, NEW_CELL_DESC);
        verifyOffenderBookingLivingUnit(BOOKING_ID, NEW_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, NEW_CELL, "BEH", expectedDateTime);
    }

    @Test
    public void notFound() {
        final var dateTime = LocalDateTime.now().minusHours(1);
        final var invalidBookingId = "-69854";

        final var response = requestMoveToCellSwap(validToken(), invalidBookingId,  "BEH", dateTime.plusMinutes(1).format(ISO_LOCAL_DATE_TIME));

        verifyErrorResponse(response, NOT_FOUND, invalidBookingId);
        verifyOffenderBookingLivingUnit(BOOKING_ID, INITIAL_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, INITIAL_CELL);
    }

    @Test
    public void noBookingAccess_notFound() {
        final var dateTime = LocalDateTime.now().minusHours(1);

        final var response = requestMoveToCellSwap(differentAgencyToken(), BOOKING_ID_S, "BEH", dateTime.plusMinutes(1).format(ISO_LOCAL_DATE_TIME));

        verifyErrorResponse(response, NOT_FOUND, BOOKING_ID_S);
        verifyOffenderBookingLivingUnit(BOOKING_ID, INITIAL_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, INITIAL_CELL);
    }

    @Test
    public void userReadOnly_forbidden() {
        final var dateTime = LocalDateTime.now().minusHours(1);

        final var response = requestMoveToCellSwap(readOnlyToken(), BOOKING_ID_S, "BEH", dateTime.plusMinutes(1).format(ISO_LOCAL_DATE_TIME));

        verifyErrorResponse(response, FORBIDDEN, "");
        verifyOffenderBookingLivingUnit(BOOKING_ID, INITIAL_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, INITIAL_CELL);
    }

    @Test
    @WithMockUser(username = "ITAG_USER", authorities = "SCOPE_write") // Required because stubbing the BedAssignmentHistoryService means we don't pick up the usual Authentication from Spring AOP.
    public void transactionRolledBack() {
        final var dateTime = LocalDateTime.now().minusHours(1);

        doThrow(RuntimeException.class).when(bedAssignmentHistoryService).add(BOOKING_ID, NEW_CELL, "BEH", dateTime);
        final var response = requestMoveToCellSwap(validToken(), BOOKING_ID_S, "BEH", dateTime.format(ISO_LOCAL_DATE_TIME));

        verifyErrorResponse(response, INTERNAL_SERVER_ERROR, "");
        verifyOffenderBookingLivingUnit(BOOKING_ID, INITIAL_CELL);
        verifyLastBedAssignmentHistory(BOOKING_ID, INITIAL_CELL);
    }

    private String differentAgencyToken() {
        return jwtAuthenticationHelper.createJwt(
                JwtParameters.builder()
                        .username("WAI_USER")
                        .scope(List.of("read", "write"))
                        .roles(List.of())
                        .expiryTime(Duration.ofDays(365 * 10))
                        .build()
        );
    }

    @SuppressWarnings("Convert2Diamond") // Type on ParameterizedTypeReference required to work around https://bugs.openjdk.java.net/browse/JDK-8210197
    private ResponseEntity<String> requestMoveToCellSwap(final String bearerToken, final String bookingId, final String reasonCode, final String dateTime) {
        final var body = reasonCode != null ?
                Map.of("reasonCode", reasonCode, "dateTime", dateTime) :
                Map.of( "dateTime", dateTime);

        final var entity = createHttpEntity(bearerToken, body);

        return testRestTemplate.exchange(
                "/api/bookings/{bookingId}/move-to-cell-swap",
                PUT,
                entity,
                new ParameterizedTypeReference<String>() {},
                bookingId
        );

    }

    @SuppressWarnings("Convert2Diamond") // Type on ParameterizedTypeReference required to work around https://bugs.openjdk.java.net/browse/JDK-8210197
    private ResponseEntity<String> requestMoveToCell(final String bearerToken, final String bookingId, final String livingUnitId, final String reasonCode, final String dateTime) {
        final var entity = createHttpEntity(bearerToken, null);
        return testRestTemplate.exchange(
                format("/api/bookings/%s/living-unit/%s?reasonCode=%s&dateTime=%s", bookingId, livingUnitId, reasonCode, dateTime),
                PUT,
                entity,
                new ParameterizedTypeReference<String>() {
                });

    }

    private void verifySuccessResponse(final ResponseEntity<String> response, final Long bookingId, final Long internalLocationId, final String internalLocationDesc) {
        assertThat(response.getStatusCode()).isEqualTo(OK);
        assertThat(getBodyAsJsonContent(response)).extractingJsonPathNumberValue("$.bookingId").isEqualTo(bookingId.intValue());
        assertThat(getBodyAsJsonContent(response)).extractingJsonPathNumberValue("$.assignedLivingUnitId").isEqualTo(internalLocationId.intValue());
        assertThat(getBodyAsJsonContent(response)).extractingJsonPathStringValue("$.assignedLivingUnitDesc").isEqualTo(internalLocationDesc);
    }

    private void verifyErrorResponse(final ResponseEntity<String> response, final HttpStatus status, final String... partialMessages) {
        assertThat(response.getStatusCode()).isEqualTo(status);
        assertThat(getBodyAsJsonContent(response)).extractingJsonPathNumberValue("$.status").isEqualTo(status.value());
        if (!partialMessages[0].isEmpty()) {
            Arrays.stream(partialMessages).forEach(partialMessage ->
                    assertThat(getBodyAsJsonContent(response)).extractingJsonPathStringValue("$.userMessage").contains(partialMessage)
            );
        }
    }

    private void verifyOffenderBookingLivingUnit(final Long bookingId, final Long livingUnitId) {
        final var offenderBooking = offenderBookingRepository.findById(bookingId).orElseThrow();
        assertThat(offenderBooking.getAssignedLivingUnit().getLocationId()).isEqualTo(livingUnitId);
    }

    private void verifyLastBedAssignmentHistory(final Long bookingId, final Long livingUnitId, final String reason, final LocalDateTime dateTime) {
        final var bedAssignmentHistories = bedAssignmentHistoriesRepository.findAllByBedAssignmentHistoryPKOffenderBookingId(bookingId);
        assertThat(bedAssignmentHistories.get(bedAssignmentHistories.size() - 1))
                .extracting("offenderBooking.bookingId", "livingUnitId", "assignmentReason", "assignmentDate", "assignmentDateTime")
                .containsExactlyInAnyOrder(bookingId, livingUnitId, reason, dateTime.toLocalDate(), dateTime.withNano(0));
    }

    private void verifyLastBedAssignmentHistory(final Long bookingId, final Long livingUnitId) {
        final var bedAssignmentHistories = bedAssignmentHistoriesRepository.findAllByBedAssignmentHistoryPKOffenderBookingId(bookingId);
        assertThat(bedAssignmentHistories.get(bedAssignmentHistories.size() - 1))
                .extracting("offenderBooking.bookingId", "livingUnitId")
                .containsExactlyInAnyOrder(bookingId, livingUnitId);
    }
}
