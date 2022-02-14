
  CREATE TABLE "OFFENDER_CASE_OFFICERS"
   (    "CASE_OFFICER_ID" NUMBER(7,0) NOT NULL,
    "CASE_ASSIGNED_DATE" DATE NOT NULL,
    "CASE_ASSIGNED_TIME" DATE NOT NULL,
    "USER_ID" VARCHAR2(32 CHAR),
    "CASE_AGY_LOC_ID" VARCHAR2(6 CHAR),
    "OFFENDER_BOOK_ID" NUMBER(10,0) NOT NULL,
    "CREATE_DATETIME" TIMESTAMP (9) DEFAULT systimestamp NOT NULL,
    "CREATE_USER_ID" VARCHAR2(32 CHAR) DEFAULT USER NOT NULL,
    "MODIFY_DATETIME" TIMESTAMP (9),
    "MODIFY_USER_ID" VARCHAR2(32 CHAR),
    "AUDIT_TIMESTAMP" TIMESTAMP (9),
    "AUDIT_USER_ID" VARCHAR2(32 CHAR),
    "AUDIT_MODULE_NAME" VARCHAR2(65 CHAR),
    "AUDIT_CLIENT_USER_ID" VARCHAR2(64 CHAR),
    "AUDIT_CLIENT_IP_ADDRESS" VARCHAR2(39 CHAR),
    "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
    "AUDIT_ADDITIONAL_INFO" VARCHAR2(256 CHAR),
     CONSTRAINT "OFFENDER_CASE_OFFICER_PK" PRIMARY KEY ("OFFENDER_BOOK_ID", "CASE_OFFICER_ID", "CASE_ASSIGNED_DATE", "CASE_ASSIGNED_TIME")
  );

  CREATE INDEX "OFFENDER_CASE_OFFICERS_NI1" ON "OFFENDER_CASE_OFFICERS" ("CASE_OFFICER_ID");


  CREATE UNIQUE INDEX "OFFENDER_CASE_OFFICER_PK" ON "OFFENDER_CASE_OFFICERS" ("OFFENDER_BOOK_ID", "CASE_OFFICER_ID", "CASE_ASSIGNED_DATE", "CASE_ASSIGNED_TIME");
