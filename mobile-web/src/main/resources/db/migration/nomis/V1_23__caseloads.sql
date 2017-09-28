CREATE TABLE CASELOADS
(
  CASELOAD_ID                   VARCHAR(6)    PRIMARY KEY       NOT NULL,
  DESCRIPTION                   VARCHAR(40)                     NOT NULL,
  CASELOAD_TYPE                 VARCHAR(12)                     NOT NULL,
  LIST_SEQ                      INTEGER,
  TRUST_ACCOUNTS_FLAG           VARCHAR(1)    DEFAULT 'Y'       NOT NULL,
  ACCESS_PROPERTY_FLAG          VARCHAR(1)    DEFAULT 'N',
  TRUST_CASELOAD_ID             VARCHAR(6),
  PAYROLL_FLAG                  VARCHAR(1)    DEFAULT 'N'       NOT NULL,
  ACTIVE_FLAG                   VARCHAR(1)    DEFAULT 'Y'       NOT NULL,
  DEACTIVATION_DATE             DATE,
  COMMISSARY_FLAG               VARCHAR(1)    DEFAULT 'N'       NOT NULL,
  PAYROLL_TRUST_CASELOAD        VARCHAR(6),
  COMMISSARY_TRUST_CASELOAD     VARCHAR(6),
  TRUST_COMMISSARY_CASELOAD     VARCHAR(6),
  COMMUNITY_TRUST_CASELOAD      VARCHAR(6),
  MDT_FLAG                      VARCHAR(1)    DEFAULT 'N'       NOT NULL,
  CASELOAD_FUNCTION             VARCHAR(12)   DEFAULT 'GENERAL' NOT NULL,
  CREATE_DATETIME               TIMESTAMP     DEFAULT now()     NOT NULL,
  CREATE_USER_ID                VARCHAR(32)   DEFAULT USER      NOT NULL,
  MODIFY_DATETIME               TIMESTAMP,
  MODIFY_USER_ID                VARCHAR(32),
  AUDIT_TIMESTAMP               TIMESTAMP,
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);
