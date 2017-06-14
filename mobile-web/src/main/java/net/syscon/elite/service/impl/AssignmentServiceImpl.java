package net.syscon.elite.service.impl;

import net.syscon.elite.persistence.InmateRepository;
import net.syscon.elite.persistence.UserRepository;
import net.syscon.elite.security.UserSecurityUtils;
import net.syscon.elite.service.AssignmentService;
import net.syscon.elite.web.api.model.InmateAssignmentSummary;
import net.syscon.elite.web.api.model.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class AssignmentServiceImpl implements AssignmentService {

    private final UserRepository userRepository;
    private final InmateRepository inmateRepository;

    @Inject
    public AssignmentServiceImpl(UserRepository userRepository, InmateRepository inmateRepository) {
        this.userRepository = userRepository;
        this.inmateRepository = inmateRepository;
    }

    @Override
    public List<InmateAssignmentSummary> findMyAssignments(int offset, int limit) {
        final String username = UserSecurityUtils.getCurrentUsername();
        final UserDetails loggedInUser = userRepository.findByUsername(username);
        return inmateRepository.findMyAssignments(loggedInUser.getStaffId(), loggedInUser.getActiveCaseLoadId(), offset, limit);
    }
}
