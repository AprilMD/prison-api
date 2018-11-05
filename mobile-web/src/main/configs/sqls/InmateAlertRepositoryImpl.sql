FIND_INMATE_ALERTS {
       SELECT ALERT_SEQ,
              ALERT_DATE,
              ALERT_TYPE,
              COALESCE(alType.DESCRIPTION, ALERT_TYPE) as ALERT_TYPE_DESC,
              ALERT_CODE,
              COALESCE(alCode.DESCRIPTION, ALERT_CODE) as ALERT_CODE_DESC,
              EXPIRY_DATE,
              ALERT_STATUS,
              COMMENT_TEXT,
              SMC.FIRST_NAME                              ADD_FIRST_NAME,
              SMC.LAST_NAME                               ADD_LAST_NAME,
              SMU.FIRST_NAME                              UPDATE_FIRST_NAME,
              SMU.LAST_NAME                               UPDATE_LAST_NAME

       FROM OFFENDER_ALERTS OA
              LEFT JOIN REFERENCE_CODES ALTYPE ON ALTYPE.DOMAIN = 'ALERT' and ALTYPE.CODE = ALERT_TYPE
              LEFT JOIN REFERENCE_CODES ALCODE ON ALCODE.DOMAIN = 'ALERT_CODE' and ALCODE.CODE = ALERT_CODE

              LEFT JOIN STAFF_USER_ACCOUNTS SUAC ON SUAC.USERNAME = OA.CREATE_USER_ID
              LEFT JOIN STAFF_MEMBERS SMC on SUAC.STAFF_ID = SMC.STAFF_ID

              LEFT JOIN STAFF_USER_ACCOUNTS SUAU on SUAU.USERNAME = OA.MODIFY_USER_ID
              left join STAFF_MEMBERS SMU on SUAU.STAFF_ID = SMU.STAFF_ID

       where OFFENDER_BOOK_ID = :bookingId
}

FIND_INMATE_ALERT {
       select ALERT_SEQ,
              ALERT_DATE,
              ALERT_TYPE,
              COALESCE(alType.DESCRIPTION, ALERT_TYPE) as ALERT_TYPE_DESC,
              ALERT_CODE,
              COALESCE(alCode.DESCRIPTION, ALERT_CODE) as ALERT_CODE_DESC,
              EXPIRY_DATE,
              COMMENT_TEXT
       from offender_alerts
              LEFT JOIN REFERENCE_CODES altype ON altype.DOMAIN = 'ALERT' and altype.CODE = ALERT_TYPE
              LEFT JOIN REFERENCE_CODES alCode ON alCode.DOMAIN = 'ALERT_CODE' and alCode.CODE = ALERT_CODE
       where OFFENDER_BOOK_ID = :bookingId
         and ALERT_SEQ = :alertSeqId
}

FIND_INMATE_OFFENDERS_ALERTS {
SELECT OA.ALERT_SEQ,
       OA.OFFENDER_BOOK_ID,
       O.OFFENDER_ID_DISPLAY,
       OA.ALERT_DATE,
       OA.ALERT_TYPE,
       COALESCE(ALTYPE.DESCRIPTION, OA.ALERT_TYPE) AS ALERT_TYPE_DESC,
       OA.ALERT_CODE,
       COALESCE(ALCODE.DESCRIPTION, OA.ALERT_CODE) AS ALERT_CODE_DESC,
       OA.EXPIRY_DATE,
       OA.ALERT_STATUS,
       OA.COMMENT_TEXT
FROM OFFENDER_ALERTS OA
  INNER JOIN OFFENDER_BOOKINGS B ON B.OFFENDER_BOOK_ID = OA.OFFENDER_BOOK_ID
  INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
  LEFT JOIN REFERENCE_CODES ALTYPE ON ALTYPE.DOMAIN = 'ALERT' AND ALTYPE.CODE = OA.ALERT_TYPE
  LEFT JOIN REFERENCE_CODES ALCODE ON ALCODE.DOMAIN = 'ALERT_CODE' AND ALCODE.CODE = OA.ALERT_CODE
WHERE B.ACTIVE_FLAG = 'Y' AND O.OFFENDER_ID_DISPLAY IN (:offenderNos)
  AND B.AGY_LOC_ID = :agencyId
}
