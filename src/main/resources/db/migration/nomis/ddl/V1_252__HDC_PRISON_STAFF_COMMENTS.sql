
  CREATE TABLE "HDC_PRISON_STAFF_COMMENTS"
   (    "OFFENDER_BOOK_ID" NUMBER(10,0),
    "COMMENT_SEQ" NUMBER(5,0) NOT NULL,
    "COMMENT_TEXT" VARCHAR2(4000 CHAR) NOT NULL,
    "SUITABLE_FLAG" VARCHAR2(1 CHAR) NOT NULL,
    "STAFF_ID" NUMBER(10,0),
    "OFFENDER_CURFEW_ID" NUMBER(10,0) NOT NULL,
    "DATE_CREATED" DATE DEFAULT sysdate,
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
     CONSTRAINT "HDC_PRISON_STAFF_COMMENTS_PK" PRIMARY KEY ("OFFENDER_CURFEW_ID", "COMMENT_SEQ")
  );

  CREATE INDEX "HDC_PRISON_STAFF_COMMENTS_FK9" ON "HDC_PRISON_STAFF_COMMENTS" ("OFFENDER_BOOK_ID");


  CREATE INDEX "HDC_PRISON_COMM_NI1" ON "HDC_PRISON_STAFF_COMMENTS" ("STAFF_ID");


  CREATE UNIQUE INDEX "HDC_PRISON_STAFF_COMMENTS_PK" ON "HDC_PRISON_STAFF_COMMENTS" ("OFFENDER_CURFEW_ID", "COMMENT_SEQ");
