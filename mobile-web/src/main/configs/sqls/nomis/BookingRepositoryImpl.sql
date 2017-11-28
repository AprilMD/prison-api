GET_BOOKING_SENTENCE_DETAIL {
  SELECT OB.OFFENDER_BOOK_ID,
    (SELECT MIN(OST.START_DATE)
     FROM OFFENDER_SENTENCE_TERMS OST
     WHERE OST.SENTENCE_TERM_CODE = 'IMP'
     AND OST.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OST.OFFENDER_BOOK_ID) AS SENTENCE_START_DATE,
    SED AS SENTENCE_EXPIRY_DATE,
    LED AS LICENCE_EXPIRY_DATE,
    PED AS PAROLE_ELIGIBILITY_DATE,
    HDCED AS HOME_DET_CURF_ELIGIBILITY_DATE,
    HDCAD_OVERRIDED_DATE AS HOME_DET_CURF_ACTUAL_DATE,
    APD_OVERRIDED_DATE AS APPROVED_PAROLE_DATE,
    ETD AS EARLY_TERM_DATE,
    MTD AS MID_TERM_DATE,
    LTD AS LATE_TERM_DATE,
    ARD_OVERRIDED_DATE,
    ARD_CALCULATED_DATE,
    CRD_OVERRIDED_DATE,
    CRD_CALCULATED_DATE,
    NPD_OVERRIDED_DATE,
    NPD_CALCULATED_DATE,
    PRRD_OVERRIDED_DATE,
    PRRD_CALCULATED_DATE,
    ROTL AS RELEASE_ON_TEMP_LICENCE_DATE,
    ERSED AS EARLY_RELEASE_SCHEME_ELIG_DATE,
    TUSED AS TOPUP_SUPERVISION_END_DATE,
    (SELECT SUM(ADJUST_DAYS)
     FROM OFFENDER_KEY_DATE_ADJUSTS OKDA
     WHERE OKDA.SENTENCE_ADJUST_CODE = 'ADA'
     AND OKDA.ACTIVE_FLAG = 'Y'
     AND OKDA.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OKDA.OFFENDER_BOOK_ID) AS ADDITIONAL_DAYS_AWARDED
  FROM
    (SELECT OSC.OFFENDER_BOOK_ID,
            CALCULATION_DATE,
            COALESCE(SED_OVERRIDED_DATE, SED_CALCULATED_DATE) AS SED,
            COALESCE(LED_OVERRIDED_DATE, LED_CALCULATED_DATE) AS LED,
            COALESCE(PED_OVERRIDED_DATE, PED_CALCULATED_DATE) AS PED,
            COALESCE(HDCED_OVERRIDED_DATE, HDCED_CALCULATED_DATE) AS HDCED,
            COALESCE(TUSED_OVERRIDED_DATE, TUSED_CALCULATED_DATE) AS TUSED,
            COALESCE(ETD_OVERRIDED_DATE, ETD_CALCULATED_DATE) AS ETD,
            COALESCE(MTD_OVERRIDED_DATE, MTD_CALCULATED_DATE) AS MTD,
            COALESCE(LTD_OVERRIDED_DATE, LTD_CALCULATED_DATE) AS LTD,
            HDCAD_OVERRIDED_DATE,
            APD_OVERRIDED_DATE,
            ARD_OVERRIDED_DATE,
            ARD_CALCULATED_DATE,
            CRD_OVERRIDED_DATE,
            CRD_CALCULATED_DATE,
            NPD_OVERRIDED_DATE,
            NPD_CALCULATED_DATE,
            PRRD_OVERRIDED_DATE,
            PRRD_CALCULATED_DATE,
            ROTL_OVERRIDED_DATE AS ROTL,
            ERSED_OVERRIDED_DATE AS ERSED
     FROM OFFENDER_SENT_CALCULATIONS OSC
       INNER JOIN (SELECT OFFENDER_BOOK_ID, MAX(CALCULATION_DATE) AS MAX_CALC_DATE
                   FROM OFFENDER_SENT_CALCULATIONS
                   GROUP BY OFFENDER_BOOK_ID) LATEST_OSC
         ON OSC.OFFENDER_BOOK_ID = LATEST_OSC.OFFENDER_BOOK_ID
            AND OSC.CALCULATION_DATE = LATEST_OSC.MAX_CALC_DATE) CALC_DATES
    RIGHT JOIN OFFENDER_BOOKINGS OB ON CALC_DATES.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

GET_BOOKING_ACTIVITIES {
  SELECT OPP.OFFENDER_BOOK_ID AS BOOKING_ID,
	       'INT_MOV' AS EVENT_CLASS,
	       COALESCE(OCA.EVENT_STATUS, 'SCH') AS EVENT_STATUS,
         'PRISON_ACT' AS EVENT_TYPE,
         RD1.DESCRIPTION AS EVENT_TYPE_DESC,
	       CA.COURSE_ACTIVITY_TYPE AS EVENT_SUB_TYPE,
	       RD2.DESCRIPTION AS EVENT_SUB_TYPE_DESC,
	       CS.SCHEDULE_DATE AS EVENT_DATE,
	       CS.START_TIME,
	       CS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.PREMISE) AS EVENT_LOCATION,
         'PA' AS EVENT_SOURCE,
         CA.CODE AS EVENT_SOURCE_CODE,
         CA.DESCRIPTION AS EVENT_SOURCE_DESC
  FROM OFFENDER_PROGRAM_PROFILES OPP
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    INNER JOIN COURSE_ACTIVITIES CA ON CA.CRS_ACTY_ID = OPP.CRS_ACTY_ID
    INNER JOIN COURSE_SCHEDULES CS ON OPP.CRS_ACTY_ID = CS.CRS_ACTY_ID
      AND CS.SCHEDULE_DATE >= TRUNC(OPP.OFFENDER_START_DATE)
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(OPP.OFFENDER_END_DATE, CA.SCHEDULE_END_DATE, CS.SCHEDULE_DATE)
      AND CS.SCHEDULE_DATE >= TRUNC(COALESCE(:fromDate, CS.SCHEDULE_DATE))
      AND TRUNC(CS.SCHEDULE_DATE) <= COALESCE(:toDate, CS.SCHEDULE_DATE)
    LEFT JOIN OFFENDER_COURSE_ATTENDANCES OCA ON OCA.OFFENDER_BOOK_ID = OPP.OFFENDER_BOOK_ID
      AND TRUNC(OCA.EVENT_DATE) = TRUNC(CS.SCHEDULE_DATE)
      AND OCA.CRS_SCH_ID = CS.CRS_SCH_ID
    LEFT JOIN REFERENCE_CODES RD1 ON RD1.CODE = 'PRISON_ACT' AND RD1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RD2 ON RD2.CODE = CA.COURSE_ACTIVITY_TYPE AND RD2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON CA.INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON CA.AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON CA.SERVICES_ADDRESS_ID = ADDR.ADDRESS_ID
  WHERE OPP.OFFENDER_BOOK_ID = :bookingId
    AND OPP.OFFENDER_PROGRAM_STATUS = 'ALLOC'
    AND COALESCE(OPP.SUSPENDED_FLAG, 'N') = 'N'
    AND CA.ACTIVE_FLAG = 'Y'
    AND CA.COURSE_ACTIVITY_TYPE IS NOT NULL
    AND CS.CATCH_UP_CRS_SCH_ID IS NULL
    AND (UPPER(TO_CHAR(CS.SCHEDULE_DATE, 'DY')), CS.SLOT_CATEGORY_CODE) NOT IN
	    (SELECT OE.EXCLUDE_DAY, COALESCE(OE.SLOT_CATEGORY_CODE, CS.SLOT_CATEGORY_CODE)
       FROM OFFENDER_EXCLUDE_ACTS_SCHDS OE
       WHERE OE.OFF_PRGREF_ID = OPP.OFF_PRGREF_ID)
}

GET_BOOKING_APPOINTMENTS {
  SELECT OIS.OFFENDER_BOOK_ID AS BOOKING_ID,
	       OIS.EVENT_CLASS,
	       OIS.EVENT_STATUS,
         OIS.EVENT_TYPE,
         RC1.DESCRIPTION AS EVENT_TYPE_DESC,
	       OIS.EVENT_SUB_TYPE,
	       RC2.DESCRIPTION AS EVENT_SUB_TYPE_DESC,
	       OIS.EVENT_DATE,
	       OIS.START_TIME,
	       OIS.END_TIME,
         COALESCE(AIL.USER_DESC, AIL.DESCRIPTION, AGY.DESCRIPTION, ADDR.PREMISE, RC3.DESCRIPTION) AS EVENT_LOCATION,
         'APP' AS EVENT_SOURCE,
         'APP' AS EVENT_SOURCE_CODE,
         OIS.COMMENT_TEXT AS EVENT_SOURCE_DESC
  FROM OFFENDER_IND_SCHEDULES OIS
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_BOOK_ID = OIS.OFFENDER_BOOK_ID AND OB.ACTIVE_FLAG = 'Y'
    LEFT JOIN REFERENCE_CODES RC1 ON RC1.CODE = OIS.EVENT_TYPE AND RC1.DOMAIN = 'INT_SCH_TYPE'
    LEFT JOIN REFERENCE_CODES RC2 ON RC2.CODE = OIS.EVENT_SUB_TYPE AND RC2.DOMAIN = 'INT_SCH_RSN'
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OIS.TO_INTERNAL_LOCATION_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN AGENCY_LOCATIONS AGY ON OIS.TO_AGY_LOC_ID = AGY.AGY_LOC_ID
    LEFT JOIN ADDRESSES ADDR ON OIS.TO_ADDRESS_ID = ADDR.ADDRESS_ID
    LEFT JOIN REFERENCE_CODES RC3 ON RC3.CODE = OIS.TO_CITY_CODE AND RC3.DOMAIN = 'CITY'
  WHERE OIS.OFFENDER_BOOK_ID = :bookingId
    AND OIS.EVENT_TYPE = 'APP'
    AND OIS.EVENT_STATUS = 'SCH'
    AND OIS.EVENT_DATE >= TRUNC(COALESCE(:fromDate, OIS.EVENT_DATE))
    AND TRUNC(OIS.EVENT_DATE) <= COALESCE(:toDate, OIS.EVENT_DATE)
}
