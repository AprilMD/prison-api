package net.syscon.elite.service;

import net.syscon.elite.api.model.StaffDetail;
import net.syscon.elite.repository.CaseLoadRepository;
import net.syscon.elite.repository.StaffRepository;
import net.syscon.elite.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
public class StaffServiceImplTest {

    private static final Long ID_MULTIPLE = 8888L;
    private static final Long ID_SINGLE = 9999L;
    private static final Long ID_NONE = 9999L;
    private static final Long ID_BAD = 123L;

    private List<String> multipleAddresses = List.of("test1@a.com", "test2@b.com", "test3@c.com");
    private List<String> singleAddress = List.of("test1@a.com");
    private List<String> emptyList = Collections.emptyList();

    @Mock
    public StaffRepository staffRepository;

    @Mock
    public CaseLoadRepository caseLoadRepository;

    @Mock
    public UserRepository userRepository;

    private StaffService staffService;

    @BeforeEach
    public void init() {
        staffService = new StaffService(staffRepository, userRepository, caseLoadRepository);
    }

    @Test
    public void testMultipleEmails() {
        when(staffRepository.findByStaffId(ID_MULTIPLE)).thenReturn(getValidStaffDetails(ID_MULTIPLE));
        when(staffRepository.findEmailAddressesForStaffId(ID_MULTIPLE)).thenReturn(multipleAddresses);

        final var addresses = staffService.getStaffEmailAddresses(ID_MULTIPLE);

        assertThat(addresses).containsOnly(multipleAddresses.get(0), multipleAddresses.get(1), multipleAddresses.get(2));

        verify(staffRepository, times(1)).findByStaffId(ID_MULTIPLE);
        verify(staffRepository, times(1)).findEmailAddressesForStaffId(ID_MULTIPLE);
    }

    @Test
    public void testSingleEmail() {

        when(staffRepository.findByStaffId(ID_SINGLE)).thenReturn(getValidStaffDetails(ID_SINGLE));
        when(staffRepository.findEmailAddressesForStaffId(ID_SINGLE)).thenReturn(singleAddress);

        final var addresses = staffService.getStaffEmailAddresses(ID_SINGLE);

        assertThat(addresses).containsOnly(singleAddress.get(0));

        verify(staffRepository, times(1)).findByStaffId(ID_SINGLE);
        verify(staffRepository, times(1)).findEmailAddressesForStaffId(ID_SINGLE);
    }

    @Test
    public void testNoneExist() throws NoContentException {
        when(staffRepository.findByStaffId(ID_NONE)).thenReturn(getValidStaffDetails(ID_NONE));
        when(staffRepository.findEmailAddressesForStaffId(ID_NONE)).thenReturn(emptyList);

        assertThatThrownBy(() -> {
            final var addresses = staffService.getStaffEmailAddresses(ID_NONE);
        }).isInstanceOf(NoContentException.class);

        verify(staffRepository, times(1)).findByStaffId(ID_NONE);
        verify(staffRepository, times(1)).findEmailAddressesForStaffId(ID_NONE);
    }

    @Test
    public void testInvalidId() throws EntityNotFoundException, NoContentException {
        when(staffRepository.findByStaffId(ID_BAD)).thenThrow(EntityNotFoundException.withId(ID_BAD));

        assertThatThrownBy(() -> {
            final var addresses = staffService.getStaffEmailAddresses(ID_BAD);
        }).isInstanceOf(EntityNotFoundException.class);

        verify(staffRepository, times(1)).findByStaffId(ID_BAD);
    }

    private Optional<StaffDetail> getValidStaffDetails(final Long staffId) {
        final var staffDetail = StaffDetail.builder().staffId(staffId).firstName("Bob").lastName("Harris").status("ACTIVE").gender("M").dateOfBirth(LocalDate.EPOCH).build();
        return Optional.of(staffDetail);
    }
}
