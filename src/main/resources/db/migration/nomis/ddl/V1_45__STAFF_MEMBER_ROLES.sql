CREATE TABLE "STAFF_MEMBER_ROLES"
(
  "STAFF_ID"                      NUMBER(10, 0)                     NOT NULL ,
  "ROLE_ID"                       NUMBER(10, 0)                     NOT NULL ,
  "CREATE_DATETIME"               TIMESTAMP(9) DEFAULT systimestamp NOT NULL ,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER    NOT NULL ,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "ROLE_CODE"                     VARCHAR2(30 CHAR)                 NOT NULL ,
  "AUDIT_TIMESTAMP"               TIMESTAMP(9),
  "AUDIT_USER_ID"                 VARCHAR2(32 CHAR),
  "AUDIT_MODULE_NAME"             VARCHAR2(65 CHAR),
  "AUDIT_CLIENT_USER_ID"          VARCHAR2(64 CHAR),
  "AUDIT_CLIENT_IP_ADDRESS"       VARCHAR2(39 CHAR),
  "AUDIT_CLIENT_WORKSTATION_NAME" VARCHAR2(64 CHAR),
  "AUDIT_ADDITIONAL_INFO"         VARCHAR2(256 CHAR),
  CONSTRAINT "STAFF_MEMBER_ROLES_PK" PRIMARY KEY ("ROLE_ID", "STAFF_ID"),
  CONSTRAINT "STAFF_ROLE_STAFF_F1" FOREIGN KEY ("STAFF_ID")
  REFERENCES "STAFF_MEMBERS" ("STAFF_ID") ,
  CONSTRAINT "STAFF_ROLE_OMS_ROLE_F1" FOREIGN KEY ("ROLE_ID")
  REFERENCES "OMS_ROLES" ("ROLE_ID")   ,
  CONSTRAINT "STF_MBR_ROLES_OMS_ROLES_FK2" FOREIGN KEY ("ROLE_CODE")
  REFERENCES "OMS_ROLES" ("ROLE_CODE")
);


COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."STAFF_ID" IS 'The ID of the staff member';

COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."ROLE_ID" IS 'The ID of the OMS Role';

COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."CREATE_DATETIME" IS 'The timestamp when the record is created';

COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."CREATE_USER_ID" IS 'The user who creates the record';

COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."MODIFY_DATETIME" IS 'The timestamp when the record is modified ';

COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."MODIFY_USER_ID" IS 'The user who modifies the record';

COMMENT ON COLUMN "STAFF_MEMBER_ROLES"."ROLE_CODE" IS 'The system role (Oracle DB role)';

COMMENT ON TABLE "STAFF_MEMBER_ROLES" IS 'The staff members'' system role in TAG system';


CREATE INDEX "STAFF_MEMBERS_ROLES_X01"
  ON "STAFF_MEMBER_ROLES" ("STAFF_ID", "ROLE_CODE");


CREATE INDEX "STF_MBR_ROLES_OMS_ROLES_FK2"
  ON "STAFF_MEMBER_ROLES" ("ROLE_CODE");

