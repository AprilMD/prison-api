CREATE TABLE "OFFENDER_PRG_OBLIGATIONS"
(
  "OFFENDER_PRG_OBLIGATION_ID"    NUMBER(10, 0)                       NOT NULL ENABLE,
  "OFFENDER_BOOK_ID"              NUMBER(10, 0)                       NOT NULL ENABLE,
  "PROGRAM_ID"                    NUMBER(10, 0),
  "STATUS"                        VARCHAR2(12 CHAR) DEFAULT 'REF'     NOT NULL ENABLE,
  "START_DATE"                    DATE,
  "END_DATE"                      DATE,
  "EVENT_TYPE"                    VARCHAR2(12 CHAR)                   NOT NULL ENABLE,
  "EVENT_SUB_TYPE"                VARCHAR2(12 CHAR),
  "COMMENT_TEXT"                  VARCHAR2(240 CHAR),
  "SENTENCE_SEQ"                  NUMBER(6, 0),
  "LENGTH"                        NUMBER(6, 0),
  "LENGTH_UNIT"                   VARCHAR2(12 CHAR),
  "OFFENDER_SENT_CONDITION_ID"    NUMBER(10, 0),
  "REFERRAL_DATE"                 DATE DEFAULT sysdate                NOT NULL ENABLE,
  "STATUS_CHANGE_DATE"            DATE,
  "STATUS_CHANGE_REASON"          VARCHAR2(12 CHAR),
  "SPECIAL_NEED_FLAG"             VARCHAR2(1 CHAR) DEFAULT 'N',
  "AVAILABILITY_CODE"             VARCHAR2(12 CHAR),
  "OBLIGATION_SOURCE"             VARCHAR2(12 CHAR) DEFAULT 'ORDERED' NOT NULL ENABLE,
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp   NOT NULL ENABLE,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER      NOT NULL ENABLE,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  CONSTRAINT "OFFENDER_PRG_OBLIGATIONS_PK" PRIMARY KEY ("OFFENDER_PRG_OBLIGATION_ID") ENABLE,
  CONSTRAINT "OFF_PRG_OB_OFF_BKG_FK" FOREIGN KEY ("OFFENDER_BOOK_ID")
  REFERENCES "OFFENDER_BOOKINGS" ("OFFENDER_BOOK_ID") ENABLE,
  CONSTRAINT "OFF_PRG_OB_PRG_SERV_FK" FOREIGN KEY ("PROGRAM_ID")
  REFERENCES "PROGRAM_SERVICES" ("PROGRAM_ID") ENABLE NOVALIDATE
);


COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."OFFENDER_PRG_OBLIGATION_ID" IS 'THE PK of the offender program obligation';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."OFFENDER_BOOK_ID" IS 'The offender Book ID';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."PROGRAM_ID" IS 'The program obligation ID';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."STATUS" IS 'The status of the program';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."START_DATE" IS 'The start date of the program obligation';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."END_DATE" IS 'The end date of the program obligations';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."EVENT_TYPE" IS 'The event Type of the program obligation.  Reference code(PS_CATEGORY)';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."EVENT_SUB_TYPE" IS 'The event sub type';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."COMMENT_TEXT" IS 'The comment of the program obligation';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."SENTENCE_SEQ" IS 'The sentence seq of the obligation';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."LENGTH" IS 'The obligation length';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."LENGTH_UNIT" IS 'The obligation length unit';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."OFFENDER_SENT_CONDITION_ID" IS 'The offender sentence condition ID';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."REFERRAL_DATE" IS 'The referral data';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."STATUS_CHANGE_DATE" IS 'The date status change';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."STATUS_CHANGE_REASON" IS 'The reason of the status change';

COMMENT ON COLUMN "OFFENDER_PRG_OBLIGATIONS"."SPECIAL_NEED_FLAG" IS '?Specai needed';

COMMENT ON TABLE "OFFENDER_PRG_OBLIGATIONS" IS 'An obligation of the offender to attend an Accredited Programme';


CREATE INDEX "OFFENDER_PRG_OBLIGATIONS_FK2"
  ON "OFFENDER_PRG_OBLIGATIONS" ("OFFENDER_BOOK_ID", "SENTENCE_SEQ");


CREATE INDEX "OFFENDER_PRG_OBLIGATIONS_FK3"
  ON "OFFENDER_PRG_OBLIGATIONS" ("OFFENDER_SENT_CONDITION_ID");


CREATE INDEX "OFFENDER_PRG_OBLIGATIONS_NI1"
  ON "OFFENDER_PRG_OBLIGATIONS" ("PROGRAM_ID");


CREATE INDEX "OFFENDER_PRG_OBLIGATIONS_NI2"
  ON "OFFENDER_PRG_OBLIGATIONS" ("OFFENDER_BOOK_ID");


