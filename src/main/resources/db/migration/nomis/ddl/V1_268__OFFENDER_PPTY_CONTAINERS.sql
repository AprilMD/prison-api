
  CREATE TABLE "OFFENDER_PPTY_CONTAINERS"
   (    "PROPERTY_ONLY_FLAG" VARCHAR2(1 CHAR) DEFAULT 'N' NOT NULL,
    "PROPERTY_CONTAINER_ID" NUMBER(10,0) NOT NULL,
    "OFFENDER_BOOK_ID" NUMBER(10,0) NOT NULL,
    "AGY_LOC_ID" VARCHAR2(6 CHAR) NOT NULL,
    "ACTIVE_FLAG" VARCHAR2(1 CHAR) DEFAULT 'Y' NOT NULL,
    "PROPOSED_DISPOSAL_DATE" DATE,
    "COMMENT_TEXT" VARCHAR2(240 CHAR),
    "INTERNAL_LOCATION_ID" NUMBER(10,0),
    "CONTAINER_CODE" VARCHAR2(12 CHAR) NOT NULL,
    "EXPIRY_DATE" DATE,
    "SEAL_MARK" VARCHAR2(20 CHAR),
    "TRN_FROM_AGY_LOC_ID" VARCHAR2(6 CHAR),
    "TRN_TO_AGY_LOC_ID" VARCHAR2(6 CHAR),
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
     CONSTRAINT "OFFENDER_PPTY_CONTAINERS_PK" PRIMARY KEY ("PROPERTY_CONTAINER_ID")
  );

  CREATE INDEX "OFF_CON_AGY_LOC_F1" ON "OFFENDER_PPTY_CONTAINERS" ("AGY_LOC_ID");


  CREATE INDEX "OFF_CON_AGY_LOC_F2" ON "OFFENDER_PPTY_CONTAINERS" ("TRN_TO_AGY_LOC_ID");


  CREATE INDEX "OFF_CON_AGY_LOC_F3" ON "OFFENDER_PPTY_CONTAINERS" ("TRN_FROM_AGY_LOC_ID");


  CREATE INDEX "OFFENDER_PPTY_CONTAINERS_NI1" ON "OFFENDER_PPTY_CONTAINERS" ("INTERNAL_LOCATION_ID");


  CREATE INDEX "OFFENDER_PPTY_CONTAINERS_NI2" ON "OFFENDER_PPTY_CONTAINERS" ("OFFENDER_BOOK_ID");


  CREATE UNIQUE INDEX "OFFENDER_PPTY_CONTAINERS_PK" ON "OFFENDER_PPTY_CONTAINERS" ("PROPERTY_CONTAINER_ID");
