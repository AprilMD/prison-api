package net.syscon.elite.v2.service;

import net.syscon.elite.v2.api.model.Agency;

import java.util.List;

/**
 * Agency API (v2) service interface.
 */
public interface AgencyService {
    Agency getAgency(String agencyId);
    List<Agency> findAgenciesByCaseLoad(String caseLoadId, Long offset, Long limit);
    List<Agency> findAgenciesByUsername(String username, Long offset, Long limit);
}