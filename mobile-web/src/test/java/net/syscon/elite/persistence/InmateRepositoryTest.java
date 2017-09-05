package net.syscon.elite.persistence;

import net.syscon.elite.web.api.model.InmateDetails;
import net.syscon.elite.web.api.model.InmatesSummary;
import net.syscon.elite.web.config.PersistenceConfigs;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.security.authentication.TestingAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

import static net.syscon.elite.web.api.resource.BookingResource.Order.asc;
import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@ActiveProfiles("nomis,nomis-hsqldb")
@RunWith(SpringRunner.class)
@Transactional(propagation = Propagation.NOT_SUPPORTED)
@JdbcTest
@AutoConfigureTestDatabase(replace = NONE)
@ContextConfiguration(classes = PersistenceConfigs.class)
public class InmateRepositoryTest {

    @Autowired
    private InmateRepository repository;

    @Before
    public final void setup() {
        SecurityContextHolder.getContext().setAuthentication(new TestingAuthenticationToken("itag_user", "password"));
    }

    @Test
    public final void testFindAllImates() {
        final List<InmatesSummary> foundInmates = repository.findAllInmates(new HashSet<>(Arrays.asList("LEI", "BXI")), "", 0, 10, "lastName, firstName", asc);
        assertThat(foundInmates).isNotEmpty();
    }


    @Test
    public final void testGetOffender() {
        final Optional<InmateDetails> inmate = repository.findInmate(-1L, Collections.singleton("LEI"));
        assertThat(inmate).isPresent();
    }

}
