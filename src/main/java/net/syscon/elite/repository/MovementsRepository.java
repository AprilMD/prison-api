package net.syscon.elite.repository;

import net.syscon.elite.api.model.Movement;
import net.syscon.elite.api.model.MovementCount;
import net.syscon.elite.api.model.OffenderMovement;
import net.syscon.elite.api.model.OffenderOutToday;
import net.syscon.elite.api.model.RollCount;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public interface MovementsRepository {

    List<Movement> getRecentMovementsByDate(LocalDateTime fromDateTime, LocalDate movementDate);

    List<RollCount> getRollCount(String agencyId, String certifiedFlag);

    MovementCount getMovementCount(String agencyId, LocalDate date);

    List<Movement> getRecentMovementsByOffenders(List<String> offenderNumbers, List<String> movementTypes);

    List<OffenderOutToday> getOffendersOutOnDate(LocalDate movementDate);

    List<OffenderMovement> getEnrouteMovementsOffenderMovementList(String agencyId, LocalDate date);

    int getEnrouteMovementsOffenderCount(String agencyId, LocalDate date);
}
