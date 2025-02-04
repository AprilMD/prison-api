package uk.gov.justice.hmpps.prison.api.resource.impl;

import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;

import java.util.List;
import java.util.Map;

public class AdjudicationsResourceTest extends ResourceTest  {

    @Nested
    public class RequestAdjudicationCreationData {

        @Test
        public void returnsExpectedValue() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = "A1234AE";

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/request-creation-data",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            // Note we cannot check the adj number as it's value is dependent on other tests
            assertThatJsonFileAndStatus(response, 201, "new_adjudication_request.json");
        }

        @Test
        public void returns404IfInvalidOffenderNo() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = "INVALID_OFF_NO";

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/request-creation-data",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 404);
        }

        @Test
        public void returns403IfInvalidRole() {
            final var token = validToken(List.of("ROLE_SYSTEM_USER"));
            final var body = "INVALID_OFF_NO";

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/request-creation-data",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 403);
        }
    }

    @Nested
    public class CreateAdjudication {

        @Test
        public void returnsExpectedValue() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "offenderNo", "A1234AE",
                "adjudicationNumber", 1234567,
                "bookingId", -5L,
                "reporterName", "ITAG_USER",
                "reportedDateTime", "2021-01-04T09:12:44",
                "agencyId", "MDI",
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 201, "new_adjudication.json");
        }

        @Test
        public void returnsExpectedValue_WithOptionalData() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "offenderNo", "A1234AE",
                "adjudicationNumber", 1234,
                "bookingId", -5L,
                "reporterName", "ITAG_USER",
                "reportedDateTime", "2021-01-04T09:12:44",
                "agencyId", "MDI",
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Example statement",
                "offenceCodes", List.of("51:8D"));

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 201, "new_adjudication_with_optional_data.json");
        }

        @Test
        public void returns400IfInvalidRequest() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "bookingId", -5L,
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 400);
        }

        @Test
        public void returns404IfInvalidBooking() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "offenderNo", "Z1234ZZ",
                "adjudicationNumber", 1234,
                "bookingId", -5L,
                "reporterName", "ITAG_USER",
                "reportedDateTime", "2021-01-04T09:12:44",
                "agencyId", "MDI",
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 404);
        }

        @Test
        public void returns403IfInvalidRole() {
            final var token = validToken(List.of("ROLE_SYSTEM_USER"));
            final var body = Map.of(
                "offenderNo", "Z1234ZZ",
                "adjudicationNumber", 1234,
                "bookingId", -5L,
                "reporterName", "ITAG_USER",
                "reportedDateTime", "2021-01-04T09:12:44",
                "agencyId", "MDI",
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 403);
        }
    }

    @Nested
    public class UpdateAdjudication {

        @Test
        public void returnsExpectedValue() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Some Adjusted Comment Text"); // Note that the "Text" is used in free text searches

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-9",
                HttpMethod.PUT,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 201, "update_adjudication.json");
        }

        @Test
        public void returnsExpectedValue_WithOptionalData() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Some Adjusted Comment Text",  // Note that the "Text" is used in free text searches
                "offenceCodes", List.of("51:1B"));

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-9",
                HttpMethod.PUT,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 201, "update_adjudication_with_optional_data.json");
        }

        @Test
        public void returns400IfInvalidRequest() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-5",
                HttpMethod.PUT,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 400);
        }

        @Test
        public void returns404IfInvalidAdjudicationNumber() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var body = Map.of(
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/99",
                HttpMethod.PUT,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 404);
        }

        @Test
        public void returns403IfInvalidRole() {
            final var token = validToken(List.of("ROLE_SYSTEM_USER"));
            final var body = Map.of(
                "incidentTime", "2021-01-04T10:12:44",
                "incidentLocationId", -31L,
                "statement", "Example statement");

            final var httpEntity = createHttpEntity(token, body);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-5",
                HttpMethod.PUT,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 403);
        }
    }

    @Nested
    public class GetAdjudication {

        @Test
        public void returnsExpectedValue() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));

            final var httpEntity = createHttpEntity(token, null);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-5",
                HttpMethod.GET,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 200, "adjudication_by_number.json");
        }

        @Test
        public void returnsExpectedValue_WithOptionalData() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));

            final var httpEntity = createHttpEntity(token, null);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-1",
                HttpMethod.GET,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 200, "adjudication_by_number_with_optional_data.json");
        }

        @Test
        public void returns404IfInvalidRequest() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));

            final var httpEntity = createHttpEntity(token, null);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-199",
                HttpMethod.GET,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 404);
        }

        @Test
        public void returns403IfInvalidRole() {
            final var token = validToken(List.of("ROLE_SYSTEM_USER"));

            final var httpEntity = createHttpEntity(token, null);

            final var response = testRestTemplate.exchange(
                "/api/adjudications/adjudication/-199",
                HttpMethod.GET,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 403);
        }
    }

    @Nested
    public class GetAdjudications {
        @Test
        public void returnsExpectedValue() {
            final var token = validToken(List.of("ROLE_MAINTAIN_ADJUDICATIONS"));
            final var httpEntity = createHttpEntity(token, List.of(-5, -7, -200));

            final var response = testRestTemplate.exchange(
                "/api/adjudications",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatJsonFileAndStatus(response, 200, "adjudications_by_numbers.json");
        }

        @Test
        public void returns403IfInvalidRole() {
            final var token = validToken(List.of("ROLE_SYSTEM_USER"));
            final var httpEntity = createHttpEntity(token, List.of(-5, -200));

            final var response = testRestTemplate.exchange(
                "/api/adjudications",
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<String>() {
                });

            assertThatStatus(response, 403);
        }
    }

    @Nested
    public class AdjudicationHearings {

        final List<String> valid = List.of("ROLE_MAINTAIN_ADJUDICATIONS");
        final List<String> invalid = List.of("ROLE_SYSTEM_USER");
        final Map validRequest = Map.of("dateTimeOfHearing","2022-10-24T10:12:44", "hearingLocationId", "-31", "oicHearingType", "GOV_ADULT");
        final Map invalidRequest = Map.of("dateTimeOfHearing","not a date time", "hearingLocationId", "-31", "oicHearingType", "GOV_ADULT");
        final Map invalidLocationRequest = Map.of("dateTimeOfHearing","2022-10-24T10:12:44", "hearingLocationId", "1", "oicHearingType", "GOV_ADULT");
        final Map invalidTypeRequest = Map.of("dateTimeOfHearing","2022-10-24T10:12:44", "hearingLocationId", "-31", "oicHearingType", "WRONG");


        @Test
        public void createHearingReturns403ForInvalidRoles () {
            webTestClient.post()
                .uri("/api/adjudications/adjudication/-9/hearing")
                .headers(setAuthorisation(invalid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isForbidden();
        }
        @Test
        public void createHearingReturns404DueToNoAdjudication() {
            webTestClient.post()
                .uri( "/api/adjudications/adjudication/99/hearing")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isNotFound();
        }

        @Test
        public void createHearingReturns400() {
            webTestClient.post()
                .uri("/api/adjudications/adjudication/-9/hearing")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(invalidRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void createHearingReturns400forOicHearingType() {
            webTestClient.post()
                .uri("/api/adjudications/adjudication/-9/hearing")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(invalidTypeRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void createHearingReturns400forLocationId() {
            webTestClient.post()
                .uri("/api/adjudications/adjudication/-9/hearing")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(invalidLocationRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void createHearing() {
            webTestClient.post()
                .uri("/api/adjudications/adjudication/-9/hearing")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isCreated();
        }

        @Test
        public void amendHearingReturns403ForInvalidRoles () {
            webTestClient.put()
                .uri("/api/adjudications/adjudication/-9/hearing/-4")
                .headers(setAuthorisation(invalid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isForbidden();
        }
        @Test
        public void amendHearingReturns404DueToNoAdjudication() {
            webTestClient.put()
                .uri( "/api/adjudications/adjudication/99/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isNotFound();
        }

        @Test
        public void amendHearingReturns400() {
            webTestClient.put()
                .uri("/api/adjudications/adjudication/-9/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(invalidRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void amendHearingReturns400forOicHearingType() {
            webTestClient.put()
                .uri("/api/adjudications/adjudication/-9/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(invalidTypeRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void amendHearingReturns400forLocationId() {
            webTestClient.put()
                .uri("/api/adjudications/adjudication/-9/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(invalidLocationRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void amendHearingInvalidRequestAsHearingDoesNotBelongToAdjudication() {
            webTestClient.put()
                .uri("/api/adjudications/adjudication/-5/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void amendHearing() {
            webTestClient.put()
                .uri("/api/adjudications/adjudication/-9/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .bodyValue(validRequest)
                .exchange()
                .expectStatus().isOk();
        }


        @Test
        public void deleteHearingReturns403DueToInvalidRoles () {
            webTestClient.delete()
                .uri("/api/adjudications/adjudication/-9/hearing/1")
                .headers(setAuthorisation(invalid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .exchange()
                .expectStatus().isForbidden();
        }

        @Test
        public void deleteHearingReturns404DueToNoAdjudication() {
            webTestClient.delete()
                .uri("/api/adjudications/adjudication/99/hearing/1")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .exchange()
                .expectStatus().isNotFound();
        }

        @Test
        public void deleteHearingReturns404DueToNoHearing() {
            webTestClient.delete()
                .uri("/api/adjudications/adjudication/-9/hearing/2")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .exchange()
                .expectStatus().isNotFound();
        }

        @Test
        public void deleteHearingInvalidRequestAsHearingDoesNotBelongToAdjudication() {
            webTestClient.delete()
                .uri("/api/adjudications/adjudication/-5/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .exchange()
                .expectStatus().isBadRequest();
        }

        @Test
        public void deleteHearing() {
            webTestClient.delete()
                .uri("/api/adjudications/adjudication/-9/hearing/-4")
                .headers(setAuthorisation(valid))
                .header("Content-Type", MediaType.APPLICATION_JSON_VALUE)
                .exchange()
                .expectStatus().isOk();
        }
    }

}
