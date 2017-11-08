-----------------------------
-- OFFENDER_SENTENCE_TERMS --
-----------------------------

-- Single 'IMP' record
INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-1, 1, 1, 'IMP', 3, null, '2017-03-25', '2020-03-24', 'N');

-- Multiple 'IMP' records - earliest start date should be used
INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-2, 1, 1, 'IMP', null, 6, '2016-11-22', '2017-05-21', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-2, 2, 1, 'IMP', 2, null, '2017-05-22', '2019-05-21', 'N');

-- Multiple records with different SENTENCE_TERM_CODE values - start date should come from record having 'IMP' sentence term code
INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-3, 1, 1, 'LIC', null, 2, '2016-11-05', '2017-01-04', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-3, 2, 1, 'IMP', 5, null, '2015-03-16', '2020-03-15', 'N');

-- Single 'IMP' record
INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-4, 1, 1, 'IMP', 15, null, '2007-10-16', '2022-10-15', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-5, 1, 1, 'IMP', 6, 6, '2017-02-08', '2023-08-07', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-6, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-7, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-8, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-9, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-10, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-11, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-12, 1, 1, 'IMP', null, 9, '2017-09-01', '2018-05-31', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-13, 1, 1, 'IMP', 6, 6, '2017-02-08', '2023-08-07', 'N');

INSERT INTO OFFENDER_SENTENCE_TERMS (OFFENDER_BOOK_ID, SENTENCE_SEQ, TERM_SEQ, SENTENCE_TERM_CODE, YEARS, MONTHS, START_DATE, END_DATE, LIFE_SENTENCE_FLAG)
VALUES (-14, 1, 1, 'IMP', 15, null, '2007-10-16', '2022-10-15', 'N');

--------------------------------
-- OFFENDER_SENT_CALCULATIONS --
--------------------------------

-- Single record with CRD calc date and SED calc date - release date should match CRD calc date
-- Record also has APD
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, APD_CALCULATED_DATE, APD_OVERRIDED_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-1, -1, '2017-08-28', '2018-09-27', null, null, null, null, null, null, null, null, null, null, null, '2019-03-24', null, null, null, null, null, null, null, null, null, '2020-03-24', null, 'NEW');

-- Single record with ARD calc date, ARD override date and SED calc date - release date should match ARD override date
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-2, -2, '2017-08-28', null, null, null, null, null, null, null, null, '2018-05-21', '2018-04-21', null, null, null, null, null, null, null, null, null, null, '2019-05-21', null, 'NEW');

-- Multiple records - record with most recent CALCULATION_DATE value should be used
--  (release date should match LTD calc date and sentence end date should match SED calc date, of later record)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-3, -3, '2017-08-28', null, null, null, null, null, null, null, null, '2019-03-15', null, null, null, null, null, null, null, null, null, null, null, '2020-03-15', null, 'NEW');

INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-4, -3, '2017-09-01', null, null, null, null, null, null, '2018-09-15', null, null, null, null, null, null, null, null, null, null, null, null, null, '2020-03-15', null, 'ADJ');

-- Record for both non-DTO and DTO sentence types with all calculated dates and override (some earlier and some later than their calculated counterparts)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-5, -4, '2017-09-02', null, null, null, null, null, null, null, null, '2021-05-06', null, null, null, null, null, null, null, '2021-08-29', '2021-08-31', null, null, '2022-10-15', '2022-10-20', 'NEW');

-- Record for a non-DTO sentence type with a single overridden non-DTO release date (one of ARD/CRD/NPD/PRRD)
-- Record also has calculated HDCED and PED dates
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-6, -5, '2017-09-03', '2019-06-02', null, null, null, null, null, null, null, null, null, '2023-02-07', null, '2019-06-01', null, '2022-02-15', '2022-02-02', null, null, null, null, '2023-08-07', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) but with calculated ARD and CRD release dates (release date should match calculated ARD)
-- Record also has calculated and overridden HDCAD and APD dates
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCAD_CALCULATED_DATE, HDCAD_OVERRIDED_DATE, APD_CALCULATED_DATE, APD_OVERRIDED_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-7, -6, '2017-09-04', '2018-05-18', '2018-05-15', '2018-05-25', '2018-05-31', null, null, null, null, null, null, null, null, '2018-02-28', null, '2018-01-31', null, null, null, null, null, null, null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) but with calculated ARD and NPD release dates (release date should match calculated ARD)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-8, -7, '2017-09-04', null, null, null, null, null, null, null, null, '2018-02-28', null, null, null, null, null, '2017-12-31', null, null, null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) but with calculated ARD and PRRD release dates (release date should match calculated ARD)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-9, -8, '2017-09-04', null, null, null, null, null, null, null, null, '2018-02-28', null, null, null, null, null, null, null, '2018-03-31', null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) but with calculated CRD and NPD release dates (release date should match calculated CRD)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-10, -9, '2017-09-04', null, null, null, null, null, null, null, null, null, null, '2018-01-31', null, null, null, '2017-12-31', null, null, null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) but with calculated CRD and PRRD release dates (release date should match calculated CRD)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-11, -10, '2017-09-04', null, null, null, null, null, null, null, null, null, null, '2018-01-31', null, null, null, null, null, '2018-03-31', null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) but with calculated NPD and PRRD release dates (release date should match calculated NPD)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-12, -11, '2017-09-04', null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2017-12-31', null, '2018-03-31', null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) and with calculated PRRD release date only (release date should match calculated PRRD)
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-13, -12, '2017-09-04', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2018-03-31', null, null, null, '2018-05-31', null, 'NEW');

-- Record for a non-DTO sentence type with no overridden non-DTO release dates (one of ARD/CRD/NPD/PRRD) and with calculated NPD release date only (release date should match calculated NPD)
-- Record also has PED & LED calculated dates
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-14, -13, '2017-09-05', null, null, null, null, null, null, null, null, null, null, null, null, '2021-05-05', null, '2017-12-31', null, null, null, '2020-08-07', null, '2023-08-07', null, 'NEW');

-- Record for ETD, MTD, LTD, HDCED, HDCAD & LED calculated and override dates
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, HDCAD_CALCULATED_DATE, HDCAD_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-15, -14, '2017-09-02', '2021-01-06', '2020-12-30', '2021-01-07', '2021-01-02', '2021-02-20', '2021-02-28', '2021-03-15', '2021-03-25', null, null, null, null, null, null, null, null, null, null, null, null, '2021-09-08', '2021-09-24', '2022-10-15', '2022-10-20', 'NEW');

-- Record for OFFENDER_BOOK_ID in different case load
INSERT INTO OFFENDER_SENT_CALCULATIONS (OFFENDER_SENT_CALCULATION_ID, OFFENDER_BOOK_ID, CALCULATION_DATE, HDCED_CALCULATED_DATE, HDCED_OVERRIDED_DATE, HDCAD_CALCULATED_DATE, HDCAD_OVERRIDED_DATE, ETD_CALCULATED_DATE, ETD_OVERRIDED_DATE, MTD_CALCULATED_DATE, MTD_OVERRIDED_DATE, LTD_CALCULATED_DATE, LTD_OVERRIDED_DATE, ARD_CALCULATED_DATE, ARD_OVERRIDED_DATE, CRD_CALCULATED_DATE, CRD_OVERRIDED_DATE, PED_CALCULATED_DATE, PED_OVERRIDED_DATE, NPD_CALCULATED_DATE, NPD_OVERRIDED_DATE, PRRD_CALCULATED_DATE, PRRD_OVERRIDED_DATE, LED_CALCULATED_DATE, LED_OVERRIDED_DATE, SED_CALCULATED_DATE, SED_OVERRIDED_DATE, CALC_REASON_CODE)
VALUES (-16, -16, '2017-09-02', '2021-01-06', '2020-12-30', '2021-01-07', '2021-01-02', '2021-02-20', '2021-02-28', '2021-03-15', '2021-03-25', null, null, null, null, null, null, null, null, null, null, null, null, '2021-09-08', '2021-09-24', '2022-10-15', '2022-10-20', 'NEW');
