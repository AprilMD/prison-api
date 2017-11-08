CREATE TABLE IMPRISONMENT_STATUSES
(
  IMPRISONMENT_STATUS_ID        BIGSERIAL     PRIMARY KEY   NOT NULL,
  IMPRISONMENT_STATUS           VARCHAR(12)                 NOT NULL,
  DESCRIPTION                   VARCHAR(40)                 NOT NULL,
  BAND_CODE                     VARCHAR(12)                 NOT NULL,
  RANK_VALUE                    INTEGER                     NOT NULL,
  IMPRISONMENT_STATUS_SEQ       INTEGER,
  ACTIVE_FLAG                   VARCHAR(1)    DEFAULT 'Y'   NOT NULL,
  EXPIRY_DATE                   TIMESTAMP,
  CREATE_DATETIME               TIMESTAMP     DEFAULT now() NOT NULL,
  CREATE_USER_ID                VARCHAR(32)   DEFAULT USER  NOT NULL,
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

ALTER TABLE IMPRISONMENT_STATUSES ADD UNIQUE (IMPRISONMENT_STATUS, ACTIVE_FLAG, EXPIRY_DATE);
ALTER TABLE IMPRISONMENT_STATUSES ADD CHECK ((ACTIVE_FLAG = 'Y' AND EXPIRY_DATE IS NULL) OR (ACTIVE_FLAG = 'N' AND EXPIRY_DATE IS NOT NULL));
