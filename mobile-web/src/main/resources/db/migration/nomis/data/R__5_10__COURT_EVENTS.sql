
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-201,-1,-1,TO_DATE('02-07-2017','DD-MM-YYYY'),TO_DATE('02-07-2017 10:33:00','DD-MM-YYYY HH24:MI:SS'),'CA', 'SCH', 'COURT1',  NULL,'SENTENCE. ',NULL,'N',NULL,NULL,                              NULL, NULL,'N');
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-202,-2,-2,TO_DATE('20-02-2017','DD-MM-YYYY'),TO_DATE('20-02-2017 10:11:00','DD-MM-YYYY HH24:MI:SS'),'CA', 'COMP','ABDRCT','4016','CONVICTD.', NULL,'N',NULL,NULL,                              NULL, NULL,'N');
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-203,-3,-3,TO_DATE('24-04-2017','DD-MM-YYYY'),TO_DATE('24-04-2017 10:10:00','DD-MM-YYYY HH24:MI:SS'),'CA', 'COMP','COURT1','4531','REMANDED.', NULL,'N',NULL,NULL,                              NULL, NULL,'N');
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-204,-4,-4,TO_DATE('19-06-2017','DD-MM-YYYY'),TO_DATE('19-06-2017 10:13:00','DD-MM-YYYY HH24:MI:SS'),'CA', 'COMP','ABDRCT','1024','SENTENCE.', NULL,'N',NULL,NULL,                              NULL, NULL,'N');
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-205,-5,-5,TO_DATE('18-07-2017','DD-MM-YYYY'),TO_DATE('18-07-2017 10:00:00','DD-MM-YYYY HH24:MI:SS'),'CRT','COMP','COURT1','4531',       NULL, NULL,'N', 'N',NULL,TO_DATE('14-08-2017','DD-MM-YYYY'),'OUT','N');
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-206,-6,-6,TO_DATE('14-08-2017','DD-MM-YYYY'),TO_DATE('14-08-2017 10:00:00','DD-MM-YYYY HH24:MI:SS'),'DC', 'COMP','ABDRCT',  NULL,       NULL, NULL,'N', 'N',NULL,                              NULL,'OUT','N');
INSERT INTO COURT_EVENTS (EVENT_ID,CASE_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,AGY_LOC_ID,OUTCOME_REASON_CODE,COMMENT_TEXT,EVENT_OUTCOME,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,RESULT_CODE,NEXT_EVENT_DATE,DIRECTION_CODE,HOLD_FLAG) VALUES (-207,-7,-7,TO_DATE('14-08-2017','DD-MM-YYYY'),TO_DATE('14-08-2017 10:00:00','DD-MM-YYYY HH24:MI:SS'),'DC', 'COMP','ABDRCT',  NULL,       NULL, NULL,'N', 'N',NULL,                              NULL,'OUT','N');

INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-101,-1,TO_DATE('17-02-2017','DD-MM-YYYY'),TO_DATE('17-02-2017 17:00:00','DD-MM-YYYY HH24:MI:SS'),'PR','EXP', -201,'LEI','N','N','IN','N');
INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-102,-2,TO_DATE('17-02-2017','DD-MM-YYYY'),TO_DATE('17-02-2017 18:00:00','DD-MM-YYYY HH24:MI:SS'),'PR','COMP',-202,'LEI','N','N','IN','N');
INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-103,-3,TO_DATE('15-10-2017','DD-MM-YYYY'),TO_DATE('15-10-2017 10:00:00','DD-MM-YYYY HH24:MI:SS'),'PR','COMP',-203,'LEI','N','N','IN','N');
INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-104,-4,TO_DATE('13-02-2017','DD-MM-YYYY'),TO_DATE('13-02-2017 17:00:00','DD-MM-YYYY HH24:MI:SS'),'PR','COMP',-204,'LEI','N','N','IN','N');
INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-105,-5,TO_DATE('13-02-2017','DD-MM-YYYY'),TO_DATE('13-02-2017 17:00:00','DD-MM-YYYY HH24:MI:SS'),'PR','COMP',-205,'LEI','N','N','IN','N');
INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-106,-6,TO_DATE('13-02-2017','DD-MM-YYYY'),TO_DATE('13-02-2017 17:00:00','DD-MM-YYYY HH24:MI:SS'),'DC','EXP', -206,'LEI','N','N','IN','N');
INSERT INTO COURT_EVENTS (EVENT_ID,OFFENDER_BOOK_ID,EVENT_DATE,START_TIME,COURT_EVENT_TYPE,EVENT_STATUS,PARENT_EVENT_ID,AGY_LOC_ID,NEXT_EVENT_REQUEST_FLAG,ORDER_REQUESTED_FLAG,DIRECTION_CODE,HOLD_FLAG) VALUES (-107,-7,TO_DATE('16-10-2017','DD-MM-YYYY'),TO_DATE('16-10-2017 18:00:00','DD-MM-YYYY HH24:MI:SS'),'PR','COMP',-207,'LEI','N','N','IN','N');