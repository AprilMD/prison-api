CREATE TABLE OFFENDERS
(
  OFFENDER_ID                   BIGSERIAL     PRIMARY KEY   NOT NULL,
  OFFENDER_NAME_SEQ             INTEGER,
  ID_SOURCE_CODE                VARCHAR(12)                 NOT NULL,
  LAST_NAME                     VARCHAR(35)                 NOT NULL,
  NAME_TYPE                     VARCHAR(12),
  FIRST_NAME                    VARCHAR(35),
  MIDDLE_NAME                   VARCHAR(35),
  BIRTH_DATE                    DATE,
  SEX_CODE                      VARCHAR(12)                 NOT NULL,
  SUFFIX                        VARCHAR(12),
  LAST_NAME_SOUNDEX             VARCHAR(6),
  BIRTH_PLACE                   VARCHAR(25),
  BIRTH_COUNTRY_CODE            VARCHAR(12),
  CREATE_DATE                   DATE                        NOT NULL,
  LAST_NAME_KEY                 VARCHAR(35)                 NOT NULL,
  ALIAS_OFFENDER_ID             BIGINT,
  FIRST_NAME_KEY                VARCHAR(35),
  MIDDLE_NAME_KEY               VARCHAR(35),
  OFFENDER_ID_DISPLAY           VARCHAR(10)                 NOT NULL,
  ROOT_OFFENDER_ID              BIGINT,
  CASELOAD_TYPE                 VARCHAR(12),
  MODIFY_USER_ID                VARCHAR(32),
  MODIFY_DATETIME               TIMESTAMP,
  ALIAS_NAME_TYPE               VARCHAR(12),
  PARENT_OFFENDER_ID            BIGINT,
  UNIQUE_OBLIGATION_FLAG        VARCHAR(1)    DEFAULT NULL,
  SUSPENDED_FLAG                VARCHAR(1)    DEFAULT NULL,
  SUSPENDED_DATE                DATE,
  RACE_CODE                     VARCHAR(12),
  REMARK_CODE                   VARCHAR(12),
  ADD_INFO_CODE                 VARCHAR(12),
  BIRTH_COUNTY                  VARCHAR(20),
  BIRTH_STATE                   VARCHAR(20),
  MIDDLE_NAME_2                 VARCHAR(35),
  TITLE                         VARCHAR(12),
  AGE                           SMALLINT,
  CREATE_USER_ID                VARCHAR(40)   DEFAULT USER  NOT NULL,
  LAST_NAME_ALPHA_KEY           VARCHAR(1)    DEFAULT NULL,
  CREATE_DATETIME               TIMESTAMP     DEFAULT now() NOT NULL,
  NAME_SEQUENCE                 VARCHAR(12),
  SINGLE_OFFENDER_IDENTITY_ID   VARCHAR(36),
  AUDIT_TIMESTAMP               TIMESTAMP,
  AUDIT_USER_ID                 VARCHAR(32),
  AUDIT_MODULE_NAME             VARCHAR(65),
  AUDIT_CLIENT_USER_ID          VARCHAR(64),
  AUDIT_CLIENT_IP_ADDRESS       VARCHAR(39),
  AUDIT_CLIENT_WORKSTATION_NAME VARCHAR(64),
  AUDIT_ADDITIONAL_INFO         VARCHAR(256)
);
