
  CREATE TABLE "OFFENDER_EDUCATIONS"
   (    "OFFENDER_BOOK_ID" NUMBER(10,0) NOT NULL,
    "EDUCATION_SEQ" NUMBER(6,0) NOT NULL,
    "EDUCATION_TYPE" VARCHAR2(12 CHAR),
    "STUDY_AREA_CODE" VARCHAR2(12 CHAR),
    "EDUCATION_LEVEL_CODE" VARCHAR2(12 CHAR),
    "NUMBER_OF_YEARS" NUMBER(2,0),
    "GRADUATION_YEAR" NUMBER(4,0),
    "START_DATE" DATE,
    "COMMENT_TEXT" VARCHAR2(240 CHAR),
    "SCHOOL_NAME" VARCHAR2(240 CHAR),
    "SPECIAL_EDUCATION_FLAG" VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL,
    "CASELOAD_TYPE" VARCHAR2(12 CHAR),
    "MODIFY_USER_ID" VARCHAR2(32 CHAR),
    "MODIFY_DATETIME" TIMESTAMP (9),
    "ROOT_OFFENDER_ID" NUMBER(10,0),
    "END_DATE" DATE,
    "PARTIAL_END_DATE_FLAG" VARCHAR2(1 CHAR) DEFAULT 'N',
    "PARTIAL_START_DATE_FLAG" VARCHAR2(1 CHAR) DEFAULT 'N',
    "STUDENT_ID" VARCHAR2(32 CHAR),
    "AGY_LOC_ID" VARCHAR2(6 CHAR),
    "SCHOOL_CODE" VARCHAR2(32 CHAR),
    "CREATE_DATETIME" TIMESTAMP (9) DEFAULT systimestamp NOT NULL,
    "CREATE_USER_ID" VARCHAR2(32 CHAR) DEFAULT USER NOT NULL,
    "EDUCATION_SCHEDULE" VARCHAR2(12 CHAR) NOT NULL,
    "AUDIT_TIMESTAMP" TIMESTAMP (9),
    "AUDIT_USER_ID" VARCHAR2(32 CHAR),
    "AUDIT_MODULE_NAME" VARCHAR2(65 CHAR),
    "AUDIT_CLIENT_USER_ID" VARCHAR2(64 CHAR),
    "AUDIT_CLIENT_IP_ADDRESS" VARCHAR2(39 CHAR),
    "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
    "AUDIT_ADDITIONAL_INFO" VARCHAR2(256 CHAR),
     CONSTRAINT "OFFENDER_EDUCATIONS_PK" PRIMARY KEY ("OFFENDER_BOOK_ID", "EDUCATION_SEQ")
  );

  CREATE UNIQUE INDEX "OFFENDER_EDUCATIONS_PK" ON "OFFENDER_EDUCATIONS" ("OFFENDER_BOOK_ID", "EDUCATION_SEQ");
