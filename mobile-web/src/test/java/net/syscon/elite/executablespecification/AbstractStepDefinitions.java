package net.syscon.elite.executablespecification;

import net.syscon.elite.api.support.Order;
import net.syscon.elite.executablespecification.steps.*;
import net.syscon.elite.test.DatasourceActiveProfilesResolver;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;

import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.RANDOM_PORT;

/**
 * Abstract base class for Serenity/Cucumber BDD step definitions.
 */
@ActiveProfiles(resolver = DatasourceActiveProfilesResolver.class)
@SuppressWarnings("SpringJavaAutowiringInspection")
@ContextConfiguration
@SpringBootTest(webEnvironment = RANDOM_PORT)
abstract class AbstractStepDefinitions {
    @TestConfiguration
    static class Config {
        @Bean
        public AuthenticationSteps auth() {
            return new AuthenticationSteps();
        }

        @Bean
        public UserSteps user() {
            return new UserSteps();
        }

        @Bean
        public CaseNoteSteps caseNote() {
            return new CaseNoteSteps();
        }

        @Bean
        public CustodyStatusSteps custodyStatus() { return new CustodyStatusSteps(); }

        @Bean
        public BookingSearchSteps bookingSearch() {
            return new BookingSearchSteps();
        }

        @Bean
        public LocationsSteps location() {
            return new LocationsSteps();
        }

        @Bean
        public BookingAliasSteps bookingAlias() {
            return new BookingAliasSteps();
        }

        @Bean
        public BookingDetailSteps bookingDetail() {
            return new BookingDetailSteps();
        }

        @Bean
        public BookingSentenceDetailSteps bookingSentenceDetail() {
            return new BookingSentenceDetailSteps();
        }

        @Bean
        public BookingIEPSteps bookingIEP() {
            return new BookingIEPSteps();
        }

        @Bean
        public BookingActivitySteps bookingActivity() {
            return new BookingActivitySteps();
        }

        @Bean
        public BookingAlertSteps bookingAlert() {
            return new BookingAlertSteps();
        }

        @Bean
        public OffenderSearchSteps offenderSearch() {
            return new OffenderSearchSteps();
        }

        @Bean
        public PrisonerSearchSteps prisonerSearch() {
            return new PrisonerSearchSteps();
        }

        @Bean
        public ReferenceDomainsSteps referenceDomains() {
            return new ReferenceDomainsSteps();
        }

        @Bean
        public MyAssignmentsSteps myAssignments() {
            return new MyAssignmentsSteps();
        }

        @Bean
        public FinanceSteps finance() {
            return new FinanceSteps();
        }

        @Bean
        public BookingSentenceSteps bookingSentence() {
            return new BookingSentenceSteps();
        }

        @Bean
        public ContactSteps contactSteps() {
            return new ContactSteps();
        }

        @Bean
        public BookingAssessmentSteps bookingAssessment() {
            return new BookingAssessmentSteps();
        }
    }

    protected int ord2idx(String ordinal) {
        String numberOnly = StringUtils.trimToEmpty(ordinal).replaceAll("[^0-9]", "");
        int index;

        try {
            index = Integer.parseInt(numberOnly) - 1;
        } catch (NumberFormatException ex) {
            index = -1;
        }

        return index;
    }

    protected Order parseSortOrder(String sortOrder) {
        Order order;

        if (StringUtils.startsWithIgnoreCase(sortOrder, "DESC")) {
            order = Order.DESC;
        } else if (StringUtils.startsWithIgnoreCase(sortOrder, "ASC")) {
            order = Order.ASC;
        } else {
            order = null;
        }

        return order;
    }
}
