package net.syscon.elite.service;

import net.syscon.elite.api.model.Agency;

import java.util.List;

/**
 * Agency API (v2) service interface.
 */
public interface AgencyService {
    Agency getAgency(String agencyId);
    List<Agency> findAgenciesByCaseLoad(String caseLoadId, long offset, long limit);
    List<Agency> findAgenciesByUsername(String username, long offset, long limit);
}