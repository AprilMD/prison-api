CREATE TABLE OFFENDER_KEY_DATE_ADJUSTS
(
	OFFENDER_KEY_DATE_ADJUST_ID     NUMBER(10)                          NOT NULL,
	OFFENDER_BOOK_ID                NUMBER(10)                          NOT NULL,
	SENTENCE_ADJUST_CODE            VARCHAR2(12)                        NOT NULL,
	ADJUST_FROM_DATE                DATE,
	ADJUST_TO_DATE                  DATE,
	ADJUST_DAYS                     NUMBER(6),
	ADJUST_STATUS                   VARCHAR2(12),
	COMMENT_TEXT                    VARCHAR2(240),
	ADJUST_DATE                     DATE,
	CREATE_DATETIME                 TIMESTAMP(9)  DEFAULT SYSTIMESTAMP  NOT NULL,
	CREATE_USER_ID                  VARCHAR2(32)  DEFAULT USER          NOT NULL,
	MODIFY_DATETIME                 TIMESTAMP(9)  DEFAULT SYSTIMESTAMP,
	MODIFY_USER_ID                  VARCHAR2(32),
	SEAL_FLAG                       VARCHAR2(1)
);

ALTER TABLE OFFENDER_KEY_DATE_ADJUSTS ADD CONSTRAINT OFFENDER_KEY_DATE_ADJUSTS_PK PRIMARY KEY (OFFENDER_KEY_DATE_ADJUST_ID);
--ALTER TABLE OFFENDER_KEY_DATE_ADJUSTS ADD FOREIGN KEY (OFFENDER_BOOK_ID) REFERENCES OFFENDER_BOOKINGS;


CREATE TABLE OFFENDER_SENTENCE_ADJUSTS
(
	OFFENDER_SENTENCE_ADJUST_ID     NUMBER(10)                          NOT NULL,
	SENTENCE_ADJUST_CODE            VARCHAR2(12)                        NOT NULL,
	ADJUST_DATE                     DATE,
	ADJUST_DAYS                     NUMBER(6),
	ADJUST_STATUS                   VARCHAR2(12),
	OFFENDER_BOOK_ID                NUMBER(10)                          NOT NULL,
	SENTENCE_SEQ                    NUMBER(6)                           NOT NULL,
	CREATE_DATETIME                 TIMESTAMP(9)  DEFAULT SYSTIMESTAMP  NOT NULL,
	CREATE_USER_ID                  VARCHAR2(32)  DEFAULT USER          NOT NULL,
	MODIFY_DATETIME                 TIMESTAMP(9)  DEFAULT SYSTIMESTAMP,
	MODIFY_USER_ID                  VARCHAR2(32),
	OFFENDER_KEY_DATE_ADJUST_ID     NUMBER(10),
	ADJUST_FROM_DATE                DATE,
	ADJUST_TO_DATE                  DATE,
	COMMENT_TEXT                    VARCHAR2(240),
	SEAL_FLAG                       VARCHAR2(1)
);

ALTER TABLE OFFENDER_SENTENCE_ADJUSTS ADD CONSTRAINT OFFENDER_SENTENCE_ADJUSTS_PK PRIMARY KEY (OFFENDER_SENTENCE_ADJUST_ID);
--ALTER TABLE OFFENDER_SENTENCE_ADJUSTS ADD FOREIGN KEY (OFFENDER_BOOK_ID) REFERENCES OFFENDER_BOOKINGS;
--ALTER TABLE OFFENDER_SENTENCE_ADJUSTS ADD FOREIGN KEY (OFFENDER_KEY_DATE_ADJUST_ID) REFERENCES OFFENDER_KEY_DATE_ADJUSTS;
--ALTER TABLE OFFENDER_SENTENCE_ADJUSTS ADD FOREIGN KEY (OFFENDER_BOOK_ID, SENTENCE_SEQ) REFERENCES OFFENDER_SENTENCES;