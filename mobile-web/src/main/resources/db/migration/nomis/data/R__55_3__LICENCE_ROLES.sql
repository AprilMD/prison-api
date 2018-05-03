INSERT INTO CONTACT_PERSON_TYPES (CONTACT_TYPE, RELATIONSHIP_TYPE, LIST_SEQ, ACTIVE_FLAG, UPDATE_ALLOWED_FLAG, CONTACT_CLASS)
VALUES ('O', 'COM', 99, 'Y', 'Y', 'OFF');

INSERT INTO REFERENCE_CODES (DOMAIN, CODE, DESCRIPTION, LIST_SEQ, ACTIVE_FLAG, SYSTEM_DATA_FLAG, EXPIRED_DATE, PARENT_DOMAIN, PARENT_CODE)
VALUES ('RELATIONSHIP', 'COM', 'Community Offender Manager', 99, 'Y', 'N', NULL, 'CONTACTS', 'O');

INSERT INTO REFERENCE_CODES (DOMAIN, CODE, DESCRIPTION, LIST_SEQ, ACTIVE_FLAG, SYSTEM_DATA_FLAG)
VALUES ('ID_TYPE', 'EXTERNAL_REL', 'External Relationship', 99, 'N', 'N');


