package net.syscon.elite.repository.impl;

import lombok.extern.slf4j.Slf4j;
import net.syscon.elite.api.model.RecallBooking;
import net.syscon.util.DateTimeConverter;
import org.apache.commons.lang3.Validate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Types;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;

@Slf4j
@Repository
public class RecallBookingImpl {
    public static final String DEFAULT_IMPRISONMENT_STATUS = "UNKNOWN";
    public static final String DEFAULT_FROM_LOCATION = "OUT";

    @Qualifier("dataSource")
    private final DataSource dataSource;

    public RecallBookingImpl(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Long recallBooking(String agencyId, RecallBooking recallBooking) {
        Validate.notNull(recallBooking);

        // Set up custom error translation
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        jdbcTemplate.setExceptionTranslator(new BookingRepositorySQLErrorCodeTranslator());

        // Prepare Stored Procedure call
        final SimpleJdbcCall recallBookingProc = new SimpleJdbcCall(jdbcTemplate)
                .withSchemaName("api2_owner")
                .withCatalogName("api2_offender_booking")
                .withProcedureName("reopen_latest_booking");

        // Initialise parameters
        Date now = DateTimeConverter.toDate(LocalDateTime.now());

        String youthOffender = recallBooking.getYouthOffender() ? "Y" : "N";

        MapSqlParameterSource params = new MapSqlParameterSource()
                .addValue("p_noms_id", recallBooking.getOffenderNo(), Types.VARCHAR)
                .addValue("p_last_name", recallBooking.getLastName(), Types.VARCHAR)
                .addValue("p_first_name", recallBooking.getFirstName(), Types.VARCHAR)
                .addValue("p_given_name_2", null, Types.VARCHAR)
                .addValue("p_given_name_3", null, Types.VARCHAR)
                .addValue("p_title", null, Types.VARCHAR)
                .addValue("p_suffix", null, Types.VARCHAR)
                .addValue("p_birth_date", recallBooking.getDateOfBirth(), Types.DATE)
                .addValue("p_gender", recallBooking.getGender(), Types.VARCHAR)
                .addValue("p_ethnicity", null, Types.VARCHAR)
                .addValue("p_pnc_number", null, Types.VARCHAR)
                .addValue("p_cro_number", null, Types.VARCHAR)
                .addValue("p_extn_identifier", null, Types.VARCHAR)
                .addValue("p_extn_ident_type", null, Types.VARCHAR)
                .addValue("p_force_creation", "N", Types.VARCHAR)
                .addValue("p_date", now, Types.DATE)
                .addValue("p_time", now, Types.DATE)
                .addValue("p_from_location", DEFAULT_FROM_LOCATION, Types.VARCHAR)
                .addValue("p_to_location", agencyId, Types.VARCHAR)
                .addValue("p_reason", recallBooking.getReason(), Types.VARCHAR)
                .addValue("p_youth_offender", youthOffender, Types.VARCHAR)
                .addValue("p_housing_location", null, Types.VARCHAR)
                .addValue("p_imprisonment_status", DEFAULT_IMPRISONMENT_STATUS, Types.VARCHAR);

        // Execute call
        Map<String, Object> result = recallBookingProc.execute(params);

        return ((Number) result.get("P_OFFENDER_BOOK_ID")).longValue();
    }
}
