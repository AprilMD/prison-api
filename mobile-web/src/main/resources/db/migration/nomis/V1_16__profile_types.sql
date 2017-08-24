CREATE TABLE PROFILE_TYPES
(
  PROFILE_TYPE                  VARCHAR(12),
  PROFILE_CATEGORY              VARCHAR(12),
  DESCRIPTION                   VARCHAR(40),
  LIST_SEQ                      DECIMAL(6, 0),
  MANDATORY_FLAG                VARCHAR(1)  DEFAULT 'Y',
  UPDATED_ALLOWED_FLAG          VARCHAR(1)  DEFAULT 'Y',
  CODE_VALUE_TYPE               VARCHAR(12),
  ACTIVE_FLAG                   VARCHAR(1)  DEFAULT 'Y',
  EXPIRY_DATE                   DATE,
  MODIFY_USER_ID                VARCHAR(32),
  MODIFIED_DATE                 DATE,
  CREATE_DATETIME               TIMESTAMP(6)      DEFAULT now(),
  CREATE_USER_ID                VARCHAR(32) DEFAULT USER,
  MODIFY_DATETIME               TIMESTAMP(6),
  AUDIT_TIMESTAMP               TIMESTAMP(6),
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);
