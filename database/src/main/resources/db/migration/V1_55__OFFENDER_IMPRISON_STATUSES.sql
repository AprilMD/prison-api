CREATE TABLE "OFFENDER_IMPRISON_STATUSES"
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0)                     NOT NULL ENABLE,
  "IMPRISON_STATUS_SEQ"           NUMBER(6, 0)                      NOT NULL ENABLE,
  "IMPRISONMENT_STATUS"           VARCHAR2(12 CHAR)                 NOT NULL ENABLE,
  "EFFECTIVE_DATE"                DATE                              NOT NULL ENABLE,
  "EFFECTIVE_TIME"                DATE,
  "EXPIRY_DATE"                   DATE,
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR),
  "CREATE_DATE"                   DATE,
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp NOT NULL ENABLE,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER    NOT NULL ENABLE,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  "LATEST_STATUS"                 VARCHAR2(1 CHAR) DEFAULT 'N',
  CONSTRAINT "OFFENDER_IMPRISON_STATUSES_UK1" UNIQUE ("OFFENDER_BOOK_ID", "IMPRISONMENT_STATUS", "EFFECTIVE_DATE", "EFFECTIVE_TIME", "AGY_LOC_ID"),
  CONSTRAINT "OFFENDER_IMPRISON_STATUSES_PK" PRIMARY KEY ("OFFENDER_BOOK_ID", "IMPRISON_STATUS_SEQ"),
  CONSTRAINT "OFF_INTS_OFF_BKG_F1" FOREIGN KEY ("OFFENDER_BOOK_ID")
  REFERENCES "OFFENDER_BOOKINGS" ("OFFENDER_BOOK_ID") ENABLE,
  CONSTRAINT "OFF_IMPS_AGY_LOC_F1" FOREIGN KEY ("AGY_LOC_ID")
  REFERENCES "AGENCY_LOCATIONS" ("AGY_LOC_ID") ENABLE
);


COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."OFFENDER_BOOK_ID" IS 'The Related Offender Book Identifier';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."IMPRISONMENT_STATUS" IS 'Reference Code ( IMP_STS)';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."EXPIRY_DATE" IS 'Expiry date for the data';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."AGY_LOC_ID" IS 'The Related Agency Location Identifier';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."COMMENT_TEXT" IS 'Free text comment data';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."CREATE_DATETIME" IS 'The timestamp when the record is created';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."CREATE_USER_ID" IS 'The user who creates the record';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."MODIFY_DATETIME" IS 'The timestamp when the record is modified ';

COMMENT ON COLUMN "OFFENDER_IMPRISON_STATUSES"."MODIFY_USER_ID" IS 'The user who modifies the record';


CREATE INDEX "OFFENDER_IMPRISON_STATUSES_X01"
  ON "OFFENDER_IMPRISON_STATUSES" ("OFFENDER_BOOK_ID", "LATEST_STATUS");


CREATE INDEX "OFF_IMPS_AGY_LOC_F1"
  ON "OFFENDER_IMPRISON_STATUSES" ("AGY_LOC_ID");
