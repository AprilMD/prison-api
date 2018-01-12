package net.syscon.elite.repository;

import net.syscon.elite.api.model.PrisonerSchedule;
import net.syscon.elite.api.support.Order;

import java.time.LocalDate;
import java.util.List;

public interface ScheduleRepository {

    List<PrisonerSchedule> getLocationAppointments(Long locationId, LocalDate fromDate, LocalDate toDate,
            String orderByFields, Order order);

    List<PrisonerSchedule> getLocationVisits(Long locationId, LocalDate fromDate, LocalDate toDate,
            String orderByFields, Order order);

    List<PrisonerSchedule> getLocationActivities(Long locationId, LocalDate fromDate, LocalDate toDate,
            String orderByFields, Order order);
}