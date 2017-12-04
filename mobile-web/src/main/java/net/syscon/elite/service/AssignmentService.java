package net.syscon.elite.service;

import net.syscon.elite.api.model.OffenderBooking;
import net.syscon.elite.api.support.Page;

/**
 * AssignmentService
 */
public interface AssignmentService {
    String DEFAULT_OFFENDER_SORT = "lastName,firstName,offenderNo";

    Page<OffenderBooking> findMyAssignments(String username, long offset, long limit);
}
