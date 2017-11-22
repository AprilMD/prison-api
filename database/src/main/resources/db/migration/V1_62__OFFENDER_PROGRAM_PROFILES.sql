CREATE TABLE "OFFENDER_PROGRAM_PROFILES"
(
  "OFF_PRGREF_ID"                 NUMBER(10, 0)                     NOT NULL ENABLE,
  "OFFENDER_BOOK_ID"              NUMBER(10, 0)                     NOT NULL ENABLE,
  "PROGRAM_ID"                    NUMBER(10, 0)                     NOT NULL ENABLE,
  "OFFENDER_START_DATE"           DATE,
  "OFFENDER_PROGRAM_STATUS"       VARCHAR2(12 CHAR) DEFAULT 'PLAN'  NOT NULL ENABLE,
  "CRS_ACTY_ID"                   NUMBER(10, 0),
  "REFERRAL_PRIORITY"             VARCHAR2(12 CHAR),
  "REFERRAL_DATE"                 DATE,
  "REFERRAL_COMMENT_TEXT"         VARCHAR2(1000 CHAR),
  "OFFENDER_END_REASON"           VARCHAR2(12 CHAR),
  "AGREED_TRAVEL_FARE"            NUMBER(11, 2),
  "AGREED_TRAVEL_HOUR"            NUMBER(6, 2),
  "OFFENDER_END_COMMENT_TEXT"     VARCHAR2(240 CHAR),
  "REJECT_DATE"                   DATE,
  "WAITLIST_DECISION_CODE"        VARCHAR2(12 CHAR),
  "REFERRAL_STAFF_ID"             NUMBER(10, 0),
  "OFFENDER_END_DATE"             DATE,
  "CREDIT_WORK_HOURS"             NUMBER(8, 2),
  "CREDIT_OTHER_HOURS"            NUMBER(8, 2),
  "SUSPENDED_FLAG"                VARCHAR2(1 CHAR)  DEFAULT 'N',
  "REJECT_REASON_CODE"            VARCHAR2(12 CHAR),
  "AGY_LOC_ID"                    VARCHAR2(6 CHAR),
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp NOT NULL ENABLE,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER    NOT NULL ENABLE,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "REVIEWED_BY"                   VARCHAR2(32 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  "OFFENDER_SENT_CONDITION_ID"    NUMBER(10, 0),
  "SENTENCE_SEQ"                  NUMBER(6, 0),
  "HOLIDAY_FLAG"                  VARCHAR2(1 CHAR)  DEFAULT 'N',
  "START_SESSION_NO"              NUMBER(6, 0),
  "PARENT_OFF_PRGREF_ID"          NUMBER(10, 0),
  "OFFENDER_PRG_OBLIGATION_ID"    NUMBER(10, 0),
  "PROGRAM_OFF_PRGREF_ID"         NUMBER(10, 0),
  "PROFILE_CLASS"                 VARCHAR2(12 CHAR) DEFAULT 'PRG',
  "COMPLETION_DATE"               DATE,
  "NEEDED_FLAG"                   VARCHAR2(1 CHAR)  DEFAULT 'N',
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "EARLY_END_REASON"              VARCHAR2(12 CHAR),
  CONSTRAINT "OFFENDER_PROGRAM_PROFILES_PK" PRIMARY KEY ("OFF_PRGREF_ID"),
  CONSTRAINT "OFF_PRGREF_OB_FK" FOREIGN KEY ("OFFENDER_BOOK_ID")
  REFERENCES "OFFENDER_BOOKINGS" ("OFFENDER_BOOK_ID") ENABLE,
  CONSTRAINT "OFF_PRG_PRFL_OFF_PRG_OBG_FK" FOREIGN KEY ("OFFENDER_PRG_OBLIGATION_ID")
  REFERENCES "OFFENDER_PRG_OBLIGATIONS" ("OFFENDER_PRG_OBLIGATION_ID") ENABLE,
  CONSTRAINT "OFF_PRG_PRFL_OFF_PRG_PRFL_FK2" FOREIGN KEY ("PROGRAM_OFF_PRGREF_ID")
  REFERENCES "OFFENDER_PROGRAM_PROFILES" ("OFF_PRGREF_ID") ENABLE,
  CONSTRAINT "OFF_PRG_PRFL_STF_FK" FOREIGN KEY ("REFERRAL_STAFF_ID")
  REFERENCES "STAFF_MEMBERS" ("STAFF_ID") ENABLE,
  CONSTRAINT "OFF_PRG_PROF_CRS_ACTY_FK" FOREIGN KEY ("CRS_ACTY_ID")
  REFERENCES "COURSE_ACTIVITIES" ("CRS_ACTY_ID") ENABLE,
  CONSTRAINT "OFF_PRG_PROF_PRG_SERV_FK" FOREIGN KEY ("PROGRAM_ID")
  REFERENCES "PROGRAM_SERVICES" ("PROGRAM_ID") ENABLE NOVALIDATE
);


COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFF_PRGREF_ID" IS 'The unique identifier of the offender program profile';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_BOOK_ID" IS 'Offender Book Id';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."PROGRAM_ID" IS 'The ID of the program';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_START_DATE" IS 'The Date the Offender is due to start on the Course/Activity';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_PROGRAM_STATUS" IS 'The Assignment Status.  Reference Codes(OFF_PRG_STS)';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."CRS_ACTY_ID" IS 'The Course Activity ID';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REFERRAL_PRIORITY" IS 'The Priority Of the Referral.  Reference Codes(PS_PRIORITY)';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REFERRAL_DATE" IS 'The date of the referral';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REFERRAL_COMMENT_TEXT" IS 'Comment Text of the referral';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_END_REASON" IS 'The reason of ending the program assignment.  Reference Codes(PS_END_RSN)';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."AGREED_TRAVEL_FARE" IS 'Define the travel fare for the programme';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."AGREED_TRAVEL_HOUR" IS 'Define the hours which is credited to offender who worked for each scheduled appearance';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_END_COMMENT_TEXT" IS 'The comment on the ending of the assignment';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REJECT_DATE" IS 'The date the referral is rejected';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."WAITLIST_DECISION_CODE" IS 'The decison on the waiting referral.  Reference Codes(PS_ACT_DEC)';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REFERRAL_STAFF_ID" IS 'The staff who makes the referral';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_END_DATE" IS 'The end date of the program assignment';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."CREDIT_WORK_HOURS" IS 'The credit work hours';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."CREDIT_OTHER_HOURS" IS 'The other credit hours';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."SUSPENDED_FLAG" IS 'If the program assignment temporarily suspended';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REJECT_REASON_CODE" IS 'The reason of rejecting the referral';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."AGY_LOC_ID" IS 'The agency location of the record owner';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."CREATE_DATETIME" IS 'The timestamp when the record is created';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."CREATE_USER_ID" IS 'The timestamp when the record is created';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."MODIFY_DATETIME" IS 'The user who creates the record';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."MODIFY_USER_ID" IS 'The timestamp when the record is modified ';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."REVIEWED_BY" IS 'The user who modifies the record';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_SENT_CONDITION_ID" IS 'The offender sentence condition ID';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."SENTENCE_SEQ" IS 'The sentence seq';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."HOLIDAY_FLAG" IS '?If holidays applied to the offender programme';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."START_SESSION_NO" IS 'The course session offender starts at';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."PARENT_OFF_PRGREF_ID" IS 'The structure of the offender programme';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."OFFENDER_PRG_OBLIGATION_ID" IS 'The offender porgram obligation';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."PROGRAM_OFF_PRGREF_ID" IS 'The offender program profile';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."PROFILE_CLASS" IS 'The Profile Class';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."COMPLETION_DATE" IS 'The date the programme completed by the offender';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."NEEDED_FLAG" IS '?If the programme Needed';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."COMMENT_TEXT" IS 'The comment text';

COMMENT ON COLUMN "OFFENDER_PROGRAM_PROFILES"."EARLY_END_REASON" IS 'The reason of early ending for ACP';

COMMENT ON TABLE "OFFENDER_PROGRAM_PROFILES" IS 'The referral and/or allocation of an offender to a program service.';


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_FK5"
  ON "OFFENDER_PROGRAM_PROFILES" ("OFFENDER_BOOK_ID", "SENTENCE_SEQ");


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_NI1"
  ON "OFFENDER_PROGRAM_PROFILES" ("CRS_ACTY_ID");


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_NI2"
  ON "OFFENDER_PROGRAM_PROFILES" ("OFFENDER_BOOK_ID", "OFFENDER_PROGRAM_STATUS", "OFFENDER_START_DATE", "OFFENDER_END_DATE", "CRS_ACTY_ID");


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_NI3"
  ON "OFFENDER_PROGRAM_PROFILES" ("OFFENDER_PROGRAM_STATUS", "OFFENDER_END_DATE");


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_NI4"
  ON "OFFENDER_PROGRAM_PROFILES" ("AGY_LOC_ID", "PROGRAM_ID");


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_NI5"
  ON "OFFENDER_PROGRAM_PROFILES" ("OFFENDER_PRG_OBLIGATION_ID");


CREATE INDEX "OFFENDER_PROGRAM_PROFILES_NI6"
  ON "OFFENDER_PROGRAM_PROFILES" ("PROGRAM_OFF_PRGREF_ID");


CREATE UNIQUE INDEX "OFFENDER_PROGRAM_PROFILES_UK"
  ON "OFFENDER_PROGRAM_PROFILES" ("OFFENDER_BOOK_ID", "CRS_ACTY_ID", DECODE("OFFENDER_PROGRAM_STATUS",
                                                                            'ALLOC', 'ALLOC',
                                                                            TO_CHAR("OFF_PRGREF_ID")));


CREATE INDEX "OFF_PRG_PRFL_OFF_COND_FK"
  ON "OFFENDER_PROGRAM_PROFILES" ("OFFENDER_SENT_CONDITION_ID");


CREATE INDEX "OFF_PRG_PRFL_STF_FK"
  ON "OFFENDER_PROGRAM_PROFILES" ("REFERRAL_STAFF_ID");


CREATE INDEX "OFF_PRG_PROF_PRG_SERV_FK"
  ON "OFFENDER_PROGRAM_PROFILES" ("PROGRAM_ID");

