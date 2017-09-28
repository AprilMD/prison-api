CREATE TABLE TAG_IMAGES
(
  TAG_IMAGE_ID                  BIGSERIAL     PRIMARY KEY   NOT NULL,
  IMAGE_OBJECT_TYPE             VARCHAR(12)                 NOT NULL,
  IMAGE_OBJECT_ID               BIGINT                      NOT NULL,
  IMAGE_OBJECT_SEQ              INTEGER,
  CAPTURE_DATETIME              TIMESTAMP                   NOT NULL,
  SET_NAME                      VARCHAR(12),
  IMAGE_VIEW_TYPE               VARCHAR(12),
  ORIENTATION_TYPE              VARCHAR(12)                 NOT NULL,
  FULL_SIZE_IMAGE               BLOB,
  THUMBNAIL_IMAGE               BLOB,
  ACTIVE_FLAG                   VARCHAR(1)    DEFAULT 'N'   NOT NULL,
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
  AUDIT_ADDITIONAL_INFO         VARCHAR(256),
  IMAGE_SOURCE_CODE             VARCHAR(12)                 NOT NULL
);
