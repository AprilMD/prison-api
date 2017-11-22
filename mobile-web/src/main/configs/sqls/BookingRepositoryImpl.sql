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
    (SELECT SUM(ADJUST_DAYS)
     FROM OFFENDER_KEY_DATE_ADJUSTS OKDA
     WHERE OKDA.SENTENCE_ADJUST_CODE = 'ADA'
     AND OKDA.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
     GROUP BY OKDA.OFFENDER_BOOK_ID) AS ADDITIONAL_DAYS_AWARDED
  FROM
    (SELECT OSC.OFFENDER_BOOK_ID,
            CALCULATION_DATE,
            COALESCE(SED_OVERRIDED_DATE, SED_CALCULATED_DATE) AS SED,
            COALESCE(LED_OVERRIDED_DATE, LED_CALCULATED_DATE) AS LED,
            COALESCE(PED_OVERRIDED_DATE, PED_CALCULATED_DATE) AS PED,
            COALESCE(HDCED_OVERRIDED_DATE, HDCED_CALCULATED_DATE) AS HDCED,
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
            PRRD_CALCULATED_DATE
     FROM OFFENDER_SENT_CALCULATIONS OSC
       INNER JOIN (SELECT OFFENDER_BOOK_ID, MAX(CALCULATION_DATE) AS MAX_CALC_DATE
                   FROM OFFENDER_SENT_CALCULATIONS
                   GROUP BY OFFENDER_BOOK_ID) LATEST_OSC
         ON OSC.OFFENDER_BOOK_ID = LATEST_OSC.OFFENDER_BOOK_ID
            AND OSC.CALCULATION_DATE = LATEST_OSC.MAX_CALC_DATE) CALC_DATES
    RIGHT JOIN OFFENDER_BOOKINGS OB ON CALC_DATES.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

GET_BOOKING_IEP_DETAILS {
  SELECT OIL.OFFENDER_BOOK_ID BOOKING_ID,
         IEP_DATE,
         IEP_TIME,
         OIL.AGY_LOC_ID AGENCY_ID,
         COALESCE(RC.DESCRIPTION, OIL.IEP_LEVEL) AS IEP_LEVEL,
         COMMENT_TEXT,
         USER_ID
  FROM OFFENDER_IEP_LEVELS OIL
    INNER JOIN OFFENDER_BOOKINGS OB ON OIL.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    LEFT JOIN REFERENCE_CODES RC ON RC.CODE = OIL.IEP_LEVEL AND RC.DOMAIN = 'IEP_LEVEL'
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
  ORDER BY OIL.IEP_DATE DESC, OIL.IEP_LEVEL_SEQ DESC
}

CHECK_BOOKING_AGENCIES {
  SELECT OFFENDER_BOOK_ID
  FROM OFFENDER_BOOKINGS
  WHERE ACTIVE_FLAG = 'Y'
  AND OFFENDER_BOOK_ID = :bookingId
  AND AGY_LOC_ID IN (:agencyIds)
}


OFFENDER_SUMMARY {
  SELECT
    OB.OFFENDER_BOOK_ID   AS                          booking_id,
    O.OFFENDER_ID_DISPLAY AS                          offender_no,
    O.TITLE,
    O.SUFFIX,
    O.FIRST_NAME,
    CONCAT(O.middle_name, CASE WHEN middle_name_2 IS NOT NULL
      THEN concat(' ', O.middle_name_2)
                          ELSE '' END)                MIDDLE_NAMES,
    O.LAST_NAME,
    OB.ACTIVE_FLAG        AS                          currently_in_prison,
    ob.agy_loc_id         AS                          agency_location_id,
    al.description                                    agency_location_desc,
    OB.LIVING_UNIT_ID     AS                          internal_location_id,
    AIL.DESCRIPTION       AS                          internal_location_desc,
    COALESCE(ord.release_date, ord.auto_release_date) RELEASE_DATE
  FROM OFFENDERS O
    JOIN OFFENDER_BOOKINGS OB
      ON OB.offender_id = o.offender_id
         AND OB.booking_seq = 1
    JOIN agency_locations al
      ON al.agy_loc_id = ob.agy_loc_id
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN offender_release_details ord
      ON ord.offender_book_id = ob.offender_book_id
  WHERE COALESCE(ord.release_date, ord.auto_release_date) <= :toReleaseDate
    AND OB.ACTIVE_FLAG = 'Y'
}