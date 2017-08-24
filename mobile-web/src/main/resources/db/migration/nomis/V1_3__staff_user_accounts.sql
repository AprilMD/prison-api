CREATE TABLE STAFF_USER_ACCOUNTS
(
  USERNAME                      VARCHAR(30),
  STAFF_ID                      DECIMAL(10, 0),
  STAFF_USER_TYPE               VARCHAR(12),
  ID_SOURCE                     VARCHAR(12),
  WORKING_CASELOAD_ID           VARCHAR(6),
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  MODIFY_USER_ID                VARCHAR(32),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);

CREATE UNIQUE INDEX STAFF_USER_ACCOUNTS_UK1 ON STAFF_USER_ACCOUNTS (STAFF_ID, STAFF_USER_TYPE);
CREATE UNIQUE INDEX STAFF_USER_ACCOUNTS_PK ON STAFF_USER_ACCOUNTS (USERNAME);

ALTER TABLE STAFF_USER_ACCOUNTS ALTER USERNAME SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER STAFF_ID SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER STAFF_USER_TYPE SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER ID_SOURCE SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER CREATE_DATETIME SET NOT NULL;
ALTER TABLE STAFF_USER_ACCOUNTS ALTER CREATE_USER_ID SET NOT NULL;