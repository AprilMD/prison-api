package net.syscon.elite.persistence;

import net.syscon.elite.web.api.model.CaseLoad;
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

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@ActiveProfiles("noHikari,nomis")
@RunWith(SpringRunner.class)
@Transactional(propagation = Propagation.NOT_SUPPORTED)
@JdbcTest
@AutoConfigureTestDatabase(replace = NONE)
@ContextConfiguration(classes = PersistenceConfigs.class)
public class CaseLoadRepositoryTest {

    @Autowired
    private CaseLoadRepository repository;

    @Before
    public final void setup() {
        SecurityContextHolder.getContext().setAuthentication(new TestingAuthenticationToken("ITAG_USER", "password"));
    }

    @Test
    public final void testFindCaseload() {
        final CaseLoad caseload = repository.find("LEI");
        assertThat(caseload).isNotNull();
        assertThat(caseload.getDescription()).isEqualTo("LEEDS (HMP)");
    }


    @Test
    public final void testGetOffender() {
        final List<CaseLoad> caseLoadsByStaffId = repository.findCaseLoadsByStaffId(-2L);
        assertThat(caseLoadsByStaffId).isNotEmpty();
        assertThat(caseLoadsByStaffId).hasSize(3);
        assertThat(caseLoadsByStaffId).extracting("caseLoadId").contains("LEI", "BXI", "WAI");
    }
    
}