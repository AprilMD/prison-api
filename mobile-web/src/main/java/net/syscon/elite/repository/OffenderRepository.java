package net.syscon.elite.repository;

import net.syscon.elite.api.model.PrisonerDetail;
import net.syscon.elite.api.support.Page;
import net.syscon.elite.api.support.PageRequest;
import net.syscon.elite.service.PrisonerDetailSearchCriteria;
import net.syscon.util.DatabaseDialect;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Provides high-performance data access services encompassing the full offender population,
 * including those that are not currently active inmates.
 */
public interface OffenderRepository {
    /**
     * Finds offenders matching specified search criteria.
     *
     * @param criteria search criteria.
     * @param pageRequest pagination and sorting criteria.
     * @return page of offender detail records.
     */
    Page<PrisonerDetail> findOffenders(PrisonerDetailSearchCriteria criteria, PageRequest pageRequest);

    enum ColumnMapper {
        ORACLE_11(DatabaseDialect.ORACLE_11, ColumnMappings.getOracleColumnMappings()),
        ORACLE_12(DatabaseDialect.ORACLE_12, ColumnMappings.getOracleColumnMappings()),
        HSQLDB(DatabaseDialect.HSQLDB, ColumnMappings.getAnsiColumnMappings());

        private final DatabaseDialect databaseDialect;
        private final Map<String, String> columnMappings;

        ColumnMapper(DatabaseDialect databaseDialect, Map<String, String> columnMappings) {
            this.databaseDialect = databaseDialect;
            this.columnMappings = columnMappings;
        }

        public static Map<String, String> getColumnMappingsForDialect(DatabaseDialect databaseDialect) {
            Map<String, String> mappings;

            switch(databaseDialect) {
                case ORACLE_11:
                    mappings = ORACLE_11.columnMappings;
                    break;
                case ORACLE_12:
                    mappings = ORACLE_12.columnMappings;
                    break;
                case HSQLDB:
                    mappings = HSQLDB.columnMappings;
                    break;
                default:
                    mappings = Collections.emptyMap();
                    break;
            }

            return mappings;
        }

        public DatabaseDialect getDatabaseDialect() {
            return databaseDialect;
        }

        public Map<String, String> getColumnMappings() {
            return columnMappings;
        }
    }
}

class ColumnMappings {
    private static final Map<String, String> ORACLE_COLUMN_MAPPINGS;
    private static final Map<String, String> ANSI_COLUMN_MAPPINGS;

    static {
        Map<String, String> oracleColumnMappings = new HashMap<>();

        oracleColumnMappings.put("pncNumber", "OI1.IDENTIFIER");
        oracleColumnMappings.put("croNumber", "OI2.IDENTIFIER");

        ORACLE_COLUMN_MAPPINGS = Collections.unmodifiableMap(oracleColumnMappings);

        Map<String, String> ansiColumnMappings = new HashMap<>();

        ansiColumnMappings.put("pncNumber", "PNC_NUMBER");
        ansiColumnMappings.put("croNumber", "CRO_NUMBER");

        ANSI_COLUMN_MAPPINGS = Collections.unmodifiableMap(ansiColumnMappings);
    }

    public static Map<String, String> getOracleColumnMappings() {
        return ORACLE_COLUMN_MAPPINGS;
    }

    public static Map<String, String> getAnsiColumnMappings() {
        return ANSI_COLUMN_MAPPINGS;
    }
}