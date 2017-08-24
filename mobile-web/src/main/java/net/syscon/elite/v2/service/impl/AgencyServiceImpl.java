package net.syscon.elite.v2.service.impl;

import lombok.extern.slf4j.Slf4j;
import net.syscon.elite.service.EntityNotFoundException;
import net.syscon.elite.v2.api.model.Agency;
import net.syscon.elite.v2.api.support.Order;
import net.syscon.elite.v2.repository.AgencyRepository;
import net.syscon.elite.v2.service.AgencyService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Agency API (v2) service implementation.
 */
@Service
@Transactional(readOnly = true)
@Slf4j
public class AgencyServiceImpl implements AgencyService {
    private final AgencyRepository agencyRepository;

    public AgencyServiceImpl(AgencyRepository agencyRepository) {
        this.agencyRepository = agencyRepository;
    }

    @Override
    public Agency getAgency(String agencyId) {
        return agencyRepository.getAgency(agencyId).orElseThrow(new EntityNotFoundException(agencyId));
    }

    @Override
    public List<Agency> findAgenciesByCaseLoad(String caseLoadId, Long offset, Long limit) {
        return agencyRepository.findAgenciesByCaseLoad(caseLoadId, "agencyId", Order.ASC);
    }

    @Override
    public List<Agency> findAgenciesByUsername(String username, Long offset, Long limit) {
        return agencyRepository.findAgenciesByUsername(username, "agencyId", Order.ASC);
    }
}