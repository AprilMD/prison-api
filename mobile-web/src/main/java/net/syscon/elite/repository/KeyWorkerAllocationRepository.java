package net.syscon.elite.repository;

import net.syscon.elite.api.model.KeyWorkerAllocationDetail;
import net.syscon.elite.api.model.Keyworker;
import net.syscon.elite.api.model.OffenderKeyWorker;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.api.support.PageRequest;

import java.util.List;
import java.util.Optional;

/**
 * Key Worker Allocation API repository interface.
 */
public interface KeyWorkerAllocationRepository {

    List<Keyworker> getAvailableKeyworkers(String agencyId);

    Optional<Keyworker> getKeyworkerDetailsByBooking(Long bookingId);

    List<KeyWorkerAllocationDetail> getAllocationDetailsForKeyworker(Long staffId);

    boolean checkKeyworkerExists(Long staffId);

    Page<OffenderKeyWorker> getAllocationHistoryByAgency(String agencyId, PageRequest pageRequest);
}
