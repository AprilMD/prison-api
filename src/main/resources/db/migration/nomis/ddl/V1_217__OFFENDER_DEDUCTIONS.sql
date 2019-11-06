
  CREATE TABLE "OFFENDER_DEDUCTIONS"
   (    "OFFENDER_DEDUCTION_ID" NUMBER(10,0) NOT NULL,
    "CASELOAD_ID" VARCHAR2(6 CHAR) NOT NULL,
    "OFFENDER_ID" NUMBER(10,0) NOT NULL,
    "CREDIT_LIMIT" NUMBER(11,2),
    "DEDUCTION_TYPE" VARCHAR2(6 CHAR) NOT NULL,
    "DEDUCTION_STATUS" VARCHAR2(1 CHAR) DEFAULT A NOT NULL,
    "DEDUCTION_PRIORITY" NUMBER(2,0) NOT NULL,
    "INFORMATION_NUMBER" VARCHAR2(32 CHAR),
    "DEDUCTION_PERCENTAGE" NUMBER(3,0),
    "PROCESS_PRIORITY_NUMBER" NUMBER(3,0) DEFAULT 99,
    "EFFECTIVE_DATE" DATE NOT NULL,
    "COMMENT_TEXT" VARCHAR2(240 CHAR),
    "FIFO_FLAG" VARCHAR2(1 CHAR) DEFAULT N,
    "PAYEE_PERSON_ID" NUMBER(10,0),
    "PAYEE_CORPORATE_ID" NUMBER(10,0),
    "MAX_MONTHLY_AMOUNT" NUMBER(11,2),
    "MAX_TOTAL_AMOUNT" NUMBER(11,2),
    "DEDUCTION_AMOUNT" NUMBER(11,2),
    "ADJUSTMENT_REASON_CODE" VARCHAR2(12 CHAR),
    "ADJUSTMENT_AMOUNT" NUMBER(11,2),
    "ADJUSTMENT_USER_ID" VARCHAR2(32 CHAR),
    "ADJUSTMENT_TXN_ID" NUMBER(10,0),
    "ADJUSTMENT_TEXT" VARCHAR2(40 CHAR),
    "MODIFY_USER_ID" VARCHAR2(32 CHAR),
    "MODIFY_DATE" DATE NOT NULL,
    "PAY_DEDUCTION_FLAG" VARCHAR2(1 CHAR) DEFAULT N,
    "MAX_RECURSIVE_AMOUNT" NUMBER(11,2),
    "GROUP_ID" NUMBER(3,0),
    "CASE_ID" NUMBER(10,0),
    "PARENT_DEDUCTION_ID" NUMBER(10,0),
    "JS_STATUS" VARCHAR2(1 CHAR) DEFAULT N,
    "COLLECT_AGENCY_AMOUNT" NUMBER(11,2),
    "COLLECT_AGENCY_FLAG" VARCHAR2(1 CHAR) DEFAULT N NOT NULL,
    "COLLECT_SENT_DATE" DATE,
    "CREATE_DATETIME" TIMESTAMP (9) DEFAULT systimestamp NOT NULL,
    "CREATE_USER_ID" VARCHAR2(32 CHAR) DEFAULT USER NOT NULL,
    "MODIFY_DATETIME" TIMESTAMP (9),
    "OFFENDER_PAYMENT_PROFILE_ID" NUMBER(10,0),
    "AUDIT_TIMESTAMP" TIMESTAMP (9),
    "AUDIT_USER_ID" VARCHAR2(32 CHAR),
    "AUDIT_MODULE_NAME" VARCHAR2(65 CHAR),
    "AUDIT_CLIENT_USER_ID" VARCHAR2(64 CHAR),
    "AUDIT_CLIENT_IP_ADDRESS" VARCHAR2(39 CHAR),
    "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
    "AUDIT_ADDITIONAL_INFO" VARCHAR2(256 CHAR),
     CONSTRAINT OFFENDER_DEDUCTIONS_PK PRIMARY KEY (OFFENDER_DEDUCTION_ID),
     CONSTRAINT OFFENDER_DEDUCTIONS_U1 UNIQUE (CASELOAD_ID,OFFENDER_ID,DEDUCTION_TYPE,DEDUCTION_PRIORITY),
     CONSTRAINT "OFFENDER_DEDUCTIONS_UI2" UNIQUE ("OFFENDER_ID", "CASELOAD_ID", "DEDUCTION_TYPE", "INFORMATION_NUMBER"),
     CONSTRAINT "OFF_DED_CSLD_DD_F1" FOREIGN KEY ("CASELOAD_ID", "DEDUCTION_TYPE")
      REFERENCES "CASELOAD_DEDUCTION_PROFILES" ("CASELOAD_ID", "DEDUCTION_TYPE"),
     CONSTRAINT "OFF_DED_OFF_DED_FK1" FOREIGN KEY ("PARENT_DEDUCTION_ID")
      REFERENCES "OFFENDER_DEDUCTIONS" ("OFFENDER_DEDUCTION_ID"),
     CONSTRAINT "OFF_DED_OFF_TA_F1" FOREIGN KEY ("CASELOAD_ID", "OFFENDER_ID")
      REFERENCES "OFFENDER_TRUST_ACCOUNTS" ("CASELOAD_ID", "OFFENDER_ID"),
     CONSTRAINT "OFF_DED_OFF_PAY_PRFL_FK" FOREIGN KEY ("OFFENDER_PAYMENT_PROFILE_ID")
      REFERENCES "OFFENDER_PAYMENT_PROFILES" ("OFFENDER_PAYMENT_PROFILE_ID"),
     CONSTRAINT "OFFENDER_DEDUCTIONS_FK10" FOREIGN KEY ("OFFENDER_ID")
      REFERENCES "OFFENDERS" ("OFFENDER_ID")
  );

  CREATE INDEX "OFF_DED_CSLD_DD_F1" ON "OFFENDER_DEDUCTIONS" ("CASELOAD_ID", "DEDUCTION_TYPE");


  CREATE INDEX "OFF_DED_OFF_DED_FK1" ON "OFFENDER_DEDUCTIONS" ("PARENT_DEDUCTION_ID");


  CREATE INDEX "OFFENDER_DEDUCTIONS_NI1" ON "OFFENDER_DEDUCTIONS" ("OFFENDER_ID", "CASELOAD_ID");


  CREATE INDEX "OFFENDER_DEDUCTIONS_NI2" ON "OFFENDER_DEDUCTIONS" ("PAYEE_PERSON_ID");


  CREATE INDEX "OFFENDER_DEDUCTIONS_NI3" ON "OFFENDER_DEDUCTIONS" ("PAYEE_CORPORATE_ID");


  CREATE INDEX "OFFENDER_DEDUCTIONS_NI4" ON "OFFENDER_DEDUCTIONS" ("CASE_ID");


  CREATE INDEX "OFFENDER_DEDUCTIONS_NI5" ON "OFFENDER_DEDUCTIONS" ("COLLECT_SENT_DATE");


  CREATE INDEX "OFFENDER_DEDUCTIONS_NI6" ON "OFFENDER_DEDUCTIONS" ("OFFENDER_PAYMENT_PROFILE_ID");


  CREATE UNIQUE INDEX "OFFENDER_DEDUCTIONS_PK" ON "OFFENDER_DEDUCTIONS" ("OFFENDER_DEDUCTION_ID");


  CREATE UNIQUE INDEX "OFFENDER_DEDUCTIONS_U1" ON "OFFENDER_DEDUCTIONS" ("CASELOAD_ID", "OFFENDER_ID", "DEDUCTION_TYPE", "DEDUCTION_PRIORITY");


  CREATE UNIQUE INDEX "OFFENDER_DEDUCTIONS_UI2" ON "OFFENDER_DEDUCTIONS" ("OFFENDER_ID", "CASELOAD_ID", "DEDUCTION_TYPE", "INFORMATION_NUMBER");
