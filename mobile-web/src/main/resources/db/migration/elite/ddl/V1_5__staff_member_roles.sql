CREATE TABLE STAFF_MEMBER_ROLES
(
  "STAFF_ID"                      NUMBER(6, 0),
  "ROLE_ID"                       NUMBER(10, 0),
  "CREATE_DATETIME"               TIMESTAMP(9)      DEFAULT systimestamp,
  "CREATE_USER_ID"                VARCHAR2(32 CHAR) DEFAULT USER,
  "MODIFY_DATETIME"               TIMESTAMP(9),
  "MODIFY_USER_ID"                VARCHAR2(32 CHAR),
  "ROLE_CODE"                     VARCHAR2(30 CHAR),
  "SEAL_FLAG"                     VARCHAR2(1 CHAR)
);

ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "STAFF_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "ROLE_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "CREATE_DATETIME" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "CREATE_USER_ID" SET NOT NULL;
ALTER TABLE "STAFF_MEMBER_ROLES" ALTER "ROLE_CODE" SET NOT NULL;