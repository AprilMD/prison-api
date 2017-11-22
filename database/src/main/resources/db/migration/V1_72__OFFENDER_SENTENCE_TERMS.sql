CREATE TABLE "OFFENDER_SENTENCE_TERMS"
(
  "OFFENDER_BOOK_ID"              NUMBER(10, 0)                     NOT NULL ENABLE,
  "SENTENCE_SEQ"                  NUMBER(6, 0)                      NOT NULL ENABLE,
  "TERM_SEQ"                      NUMBER(6, 0)                      NOT NULL ENABLE,
  "SENTENCE_TERM_CODE"            VARCHAR2(12 CHAR)                 NOT NULL ENABLE,
  "YEARS"                         NUMBER(3, 0),
  "MONTHS"                        NUMBER(3, 0),
  "WEEKS"                         NUMBER(3, 0),
  "DAYS"                          NUMBER(6, 0),
  "START_DATE"                    DATE                              NOT NULL ENABLE,
  "END_DATE"                      DATE,
  "LIFE_SENTENCE_FLAG"            VARCHAR2(1 CHAR) DEFAULT 'N',
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp NOT NULL ENABLE,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER    NOT NULL ENABLE,
  "HOURS"                         NUMBER(3, 0),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  CONSTRAINT "OFFENDER_SENTENCE_TERMS_PK" PRIMARY KEY ("OFFENDER_BOOK_ID", "SENTENCE_SEQ", "TERM_SEQ"),
  CONSTRAINT "OFF_SENT_TERM_OFF_SENT_FK" FOREIGN KEY ("OFFENDER_BOOK_ID", "SENTENCE_SEQ")
  REFERENCES "OFFENDER_SENTENCES" ("OFFENDER_BOOK_ID", "SENTENCE_SEQ") ENABLE,
  CONSTRAINT "OFFENDER_SENTENCE_TERMS_FK9" FOREIGN KEY ("OFFENDER_BOOK_ID")
  REFERENCES "OFFENDER_BOOKINGS" ("OFFENDER_BOOK_ID") ENABLE
);

