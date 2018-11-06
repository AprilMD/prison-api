package net.syscon.elite.repository.impl;

import net.syscon.elite.api.model.MovementCount;
import net.syscon.elite.api.model.Movement;
import net.syscon.elite.api.model.RollCount;
import net.syscon.elite.repository.MovementsRepository;
import net.syscon.elite.repository.mapping.StandardBeanPropertyRowMapper;
import net.syscon.util.DateTimeConverter;

import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class MovementsRepositoryImpl extends RepositoryBase implements MovementsRepository {

    private final StandardBeanPropertyRowMapper<Movement> CUSTODY_STATUS_MAPPER = new StandardBeanPropertyRowMapper<>(Movement.class);
    private final StandardBeanPropertyRowMapper<RollCount> ROLLCOUNT_MAPPER = new StandardBeanPropertyRowMapper<>(RollCount.class);

    @Override
    public List<Movement> getRecentMovementsByDate(LocalDateTime fromDateTime, LocalDate movementDate) {
        String sql = getQuery("GET_RECENT_MOVEMENTS");
        return jdbcTemplate.query(sql, createParams("fromDateTime", DateTimeConverter.fromLocalDateTime(fromDateTime),
                "movementDate", DateTimeConverter.toDate(movementDate)), CUSTODY_STATUS_MAPPER);
    }

    @Override
    public List<Movement> getRecentMovementsByOffenders(List<String> offenderNumbers, List<String> movementTypes) {
        if (movementTypes.size() != 0) {
            return jdbcTemplate.query(getQuery("GET_RECENT_MOVEMENTS_BY_OFFENDERS_AND_MOVEMENT_TYPES"), createParams(
                    "offenderNumbers", offenderNumbers,
                    "movementTypes", movementTypes),
                    CUSTODY_STATUS_MAPPER);
        }

        return jdbcTemplate.query(getQuery("GET_RECENT_MOVEMENTS_BY_OFFENDERS"), createParams(
                "offenderNumbers", offenderNumbers),
                CUSTODY_STATUS_MAPPER);
    }

    @Override
    public List<RollCount> getRollCount(String agencyId, String certifiedFlag) {
        String sql = getQuery("GET_ROLL_COUNT");
        return jdbcTemplate.query(sql, createParams(
                "agencyId", agencyId,
                "certifiedFlag", certifiedFlag,
                "livingUnitId", null),
                ROLLCOUNT_MAPPER);
    }

    @Override
    public MovementCount getMovementCount(String agencyId, LocalDate date) {
        final MovementCount result = MovementCount.builder().in(0).out(0).build();
        jdbcTemplate.query(
                getQuery("GET_ROLLCOUNT_MOVEMENTS"),
                createParams("agencyId", agencyId, "movementDate", DateTimeConverter.toDate(date)),
                new RowCallbackHandler() {
                    @Override
                    public void processRow(ResultSet rs) throws SQLException {
                        switch (rs.getString("DIRECTION_CODE")) {
                            case "IN":
                                result.setIn(rs.getInt("COUNT"));
                                break;
                            case "OUT":
                                result.setOut(rs.getInt("COUNT"));
                                break;
                            default:
                                break;
                        }
                    }
                }
        );
        return result;
    }
}