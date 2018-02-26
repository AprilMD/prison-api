  FIND_INMATE_DETAIL {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         B.AGY_LOC_ID,
         B.LIVING_UNIT_ID,
         B.ACTIVE_FLAG,
         (SELECT * FROM
           (SELECT IMAGE_ID
            FROM IMAGES
            WHERE ACTIVE_FLAG = 'Y'
            AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
            AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
            AND IMAGE_VIEW_TYPE = 'FACE'
            AND ORIENTATION_TYPE = 'FRONT'
            ORDER BY CREATE_DATETIME DESC)
          WHERE ROWNUM <= 1) AS FACE_IMAGE_ID,
         O.BIRTH_DATE,
         B.ASSIGNED_STAFF_ID AS ASSIGNED_OFFICER_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
  WHERE B.ACTIVE_FLAG = 'Y' AND B.OFFENDER_BOOK_ID = :bookingId
}

FIND_BASIC_INMATE_DETAIL {
  SELECT B.OFFENDER_BOOK_ID,
    B.BOOKING_NO,
    O.OFFENDER_ID_DISPLAY,
    O.FIRST_NAME,
    O.MIDDLE_NAME,
    O.LAST_NAME,
    O.BIRTH_DATE,
    B.AGY_LOC_ID,
    B.LIVING_UNIT_ID,
    B.ACTIVE_FLAG
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
  WHERE B.ACTIVE_FLAG = 'Y' AND B.OFFENDER_BOOK_ID = :bookingId
}

GET_IMAGE_DATA_FOR_BOOKING {
  SELECT I.IMAGE_ID,
    I.CAPTURE_DATE,
    I.IMAGE_VIEW_TYPE,
    I.ORIENTATION_TYPE,
    I.IMAGE_OBJECT_TYPE,
    I.IMAGE_OBJECT_ID
  FROM IMAGES I
  WHERE  I.IMAGE_ID =
   ( SELECT IMAGE_ID FROM
       (SELECT IMAGE_ID
     FROM IMAGES
     WHERE ACTIVE_FLAG = 'Y'
           AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
           AND IMAGE_OBJECT_ID = :bookingId
           AND IMAGE_VIEW_TYPE = 'FACE'
           AND ORIENTATION_TYPE = 'FRONT'
     ORDER BY CREATE_DATETIME DESC)
  WHERE ROWNUM <= 1)
}

FIND_ALERT_TYPES_FOR_OFFENDER {
   SELECT DISTINCT(ALERT_TYPE) AS ALERT_TYPE
   FROM OFFENDER_ALERTS A
   WHERE A.OFFENDER_BOOK_ID = :bookingId AND A.ALERT_STATUS = 'ACTIVE' ORDER BY ALERT_TYPE
}

FIND_ASSIGNED_LIVING_UNIT {
     SELECT B.AGY_LOC_ID,
            B.LIVING_UNIT_ID,
            I.DESCRIPTION LIVING_UNIT_DESCRIPTION,
            AL.DESCRIPTION as AGENCY_NAME
       FROM OFFENDER_BOOKINGS B
            LEFT JOIN AGENCY_INTERNAL_LOCATIONS I ON B.LIVING_UNIT_ID = I.INTERNAL_LOCATION_ID
            LEFT JOIN AGENCY_LOCATIONS AL ON AL.AGY_LOC_ID = B.AGY_LOC_ID
      WHERE B.ACTIVE_FLAG = 'Y' AND B.OFFENDER_BOOK_ID = :bookingId
}

FIND_ALL_INMATES {
  SELECT OB.OFFENDER_BOOK_ID,
         OB.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         OB.AGY_LOC_ID,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         O.BIRTH_DATE,
         (SELECT LISTAGG(ALERT_TYPE, ',') WITHIN GROUP (ORDER BY ALERT_TYPE)
          FROM (SELECT DISTINCT(ALERT_TYPE)
                FROM OFFENDER_ALERTS A
                WHERE OB.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID AND A.ALERT_STATUS = 'ACTIVE')) AS ALERT_TYPES,
         OB.LIVING_UNIT_ID,
         AIL.DESCRIPTION AS LIVING_UNIT_DESC,
         (SELECT *
          FROM (SELECT IMAGE_ID
                FROM IMAGES
                WHERE ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND IMAGE_OBJECT_ID = OB.OFFENDER_BOOK_ID
                AND IMAGE_VIEW_TYPE = 'FACE'
                AND ORIENTATION_TYPE = 'FRONT'
                ORDER BY CREATE_DATETIME DESC)
          WHERE ROWNUM <= 1) AS FACE_IMAGE_ID,
         S.USER_ID AS ASSIGNED_OFFICER_ID
  FROM OFFENDER_BOOKINGS OB
    INNER JOIN OFFENDERS O ON OB.OFFENDER_ID = O.OFFENDER_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON OB.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
    LEFT JOIN STAFF_MEMBERS S ON OB.ASSIGNED_STAFF_ID = S.STAFF_ID
  WHERE OB.ACTIVE_FLAG = 'Y'
}

CASELOAD_FILTER {
  EXISTS (select 1 from CASELOAD_AGENCY_LOCATIONS C WHERE OB.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID IN (:caseLoadId))
}

FIND_INMATES_BY_LOCATION {
     SELECT B.OFFENDER_BOOK_ID,
            B.BOOKING_NO,
            O.OFFENDER_ID_DISPLAY,
            B.AGY_LOC_ID,
            O.FIRST_NAME,
            O.MIDDLE_NAME,
            O.LAST_NAME,
            O.BIRTH_DATE,
            (
                SELECT LISTAGG(ALERT_TYPE, ',') WITHIN GROUP (ORDER BY ALERT_TYPE)
                  FROM (
                            SELECT DISTINCT( ALERT_TYPE)
                              FROM OFFENDER_ALERTS A
                             WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID AND A.ALERT_STATUS = 'ACTIVE'
                       )
            ) AS ALERT_TYPES,
            B.LIVING_UNIT_ID,
            (
                SELECT * FROM (
                    SELECT IMAGE_ID
                      FROM IMAGES
                     WHERE ACTIVE_FLAG = 'Y'
                           AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                           AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
                           AND IMAGE_VIEW_TYPE = 'FACE'
                           AND ORIENTATION_TYPE = 'FRONT'
                     ORDER BY CREATE_DATETIME DESC
                )
                WHERE ROWNUM <= 1
            ) AS FACE_IMAGE_ID
       FROM OFFENDER_BOOKINGS B
            INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON C.CASELOAD_ID = :caseLoadId AND B.AGY_LOC_ID = C.AGY_LOC_ID
            LEFT JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
      WHERE B.ACTIVE_FLAG = 'Y'
            AND B.LIVING_UNIT_ID IN (
                SELECT INTERNAL_LOCATION_ID
                  FROM AGENCY_INTERNAL_LOCATIONS START WITH INTERNAL_LOCATION_ID = :locationId
               CONNECT BY PRIOR INTERNAL_LOCATION_ID = PARENT_INTERNAL_LOCATION_ID
            )
}

FIND_INMATES_OF_LOCATION_LIST {
  SELECT B.OFFENDER_BOOK_ID AS BOOKING_ID,
         O.OFFENDER_ID_DISPLAY AS OFFENDER_NO,
         O.FIRST_NAME,
         O.LAST_NAME, 
         B.LIVING_UNIT_ID AS LOCATION_ID,
         AIL.DESCRIPTION AS LOCATION_DESCRIPTION
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE B.ACTIVE_FLAG = 'Y'
  AND EXISTS (select 1 from CASELOAD_AGENCY_LOCATIONS C WHERE B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID IN (:caseLoadIds))
  AND AIL.INTERNAL_LOCATION_ID in (:locations)
  AND B.AGY_LOC_ID = :agencyId
}

FIND_PHYSICAL_CHARACTERISTICS_BY_BOOKING {
  SELECT PT.PROFILE_TYPE AS TYPE,
         PT.DESCRIPTION AS CHARACTERISTIC,
         COALESCE(PC.DESCRIPTION, P.PROFILE_CODE) AS DETAIL,
         NULL AS IMAGE_ID
  FROM OFFENDER_PROFILE_DETAILS P
    INNER JOIN OFFENDER_BOOKINGS B ON B.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
    INNER JOIN PROFILE_TYPES PT ON PT.PROFILE_TYPE = P.PROFILE_TYPE
                                   AND PT.PROFILE_CATEGORY = 'PA' AND PT.ACTIVE_FLAG = 'Y'
    LEFT JOIN PROFILE_CODES PC ON PC.PROFILE_TYPE = PT.PROFILE_TYPE AND PC.PROFILE_CODE = P.PROFILE_CODE
  WHERE P.OFFENDER_BOOK_ID = :bookingId AND P.PROFILE_CODE IS NOT NULL
  ORDER BY P.LIST_SEQ
}

FIND_PROFILE_INFORMATION_BY_BOOKING {
  SELECT PT.PROFILE_TYPE AS TYPE,
         PT.DESCRIPTION AS question,
         COALESCE(PC.DESCRIPTION, P.PROFILE_CODE) AS result_value
  FROM OFFENDER_PROFILE_DETAILS P
    INNER JOIN OFFENDER_BOOKINGS B ON B.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
    INNER JOIN PROFILE_TYPES PT ON PT.PROFILE_TYPE = P.PROFILE_TYPE
                                   AND PT.PROFILE_CATEGORY = 'PI' AND PT.ACTIVE_FLAG = 'Y'
    LEFT JOIN PROFILE_CODES PC ON PC.PROFILE_TYPE = PT.PROFILE_TYPE
                                  AND PC.PROFILE_CODE = P.PROFILE_CODE
  WHERE P.OFFENDER_BOOK_ID = :bookingId AND P.PROFILE_CODE IS NOT NULL
  ORDER BY P.LIST_SEQ
}

GET_OFFENDER_IDENTIFIERS_BY_BOOKING {
  SELECT
    IDENTIFIER_TYPE "TYPE",
    OI.IDENTIFIER "VALUE",
    ISSUED_AUTHORITY_TEXT,
    ISSUED_DATE,
    OI.CASELOAD_TYPE,
    OI.OFFENDER_ID_SEQ
  FROM OFFENDER_IDENTIFIERS OI
    JOIN OFFENDERS O ON O.OFFENDER_ID = OI.OFFENDER_ID
    JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_ID = O.OFFENDER_ID
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
  AND OI.OFFENDER_ID_SEQ = (SELECT MAX(OFFENDER_ID_SEQ)
                            FROM OFFENDER_IDENTIFIERS OI2
                            WHERE OI2.OFFENDER_ID = OI.OFFENDER_ID
                            AND OI2.IDENTIFIER_TYPE = OI.IDENTIFIER_TYPE )
}

FIND_PHYSICAL_MARKS_BY_BOOKING {
    SELECT (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.MARK_TYPE AND DOMAIN='MARK_TYPE') AS TYPE,
           (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.SIDE_CODE AND DOMAIN='SIDE') AS SIDE,
           (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.BODY_PART_CODE AND DOMAIN='BODY_PART') AS BODY_PART,
           (SELECT DESCRIPTION FROM REFERENCE_CODES WHERE CODE = M.PART_ORIENTATION_CODE AND DOMAIN='PART_ORIENT') AS ORENTIATION,
           M.COMMENT_TEXT,
           (SELECT I.IMAGE_ID
              FROM IMAGES I
             WHERE B.OFFENDER_BOOK_ID = :bookingId
                   AND B.OFFENDER_BOOK_ID = I.IMAGE_OBJECT_ID
                   AND I.ACTIVE_FLAG = 'Y'
                   AND M.MARK_TYPE = I.IMAGE_VIEW_TYPE
                   AND M.BODY_PART_CODE = I.ORIENTATION_TYPE
                   AND M.ID_MARK_SEQ = I.IMAGE_OBJECT_SEQ
           ) AS IMAGE_ID
      FROM OFFENDER_BOOKINGS B
           INNER JOIN offender_identifying_marks M ON B.OFFENDER_BOOK_ID = M.OFFENDER_BOOK_ID
     WHERE B.OFFENDER_BOOK_ID = :bookingId
           AND B.ACTIVE_FLAG = 'Y'
           AND M.BODY_PART_CODE != 'CONV'
}

FIND_PHYSICAL_ATTRIBUTES_BY_BOOKING {
    SELECT O.SEX_CODE,
           O.RACE_CODE,
           RCS.DESCRIPTION AS GENDER,
           RCE.DESCRIPTION AS ETHNICITY,
           P.HEIGHT_FT,
           P.HEIGHT_IN,
           P.HEIGHT_CM,
           P.WEIGHT_LBS,
           P.WEIGHT_KG
      FROM OFFENDER_BOOKINGS B
           LEFT JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
           LEFT JOIN OFFENDER_PHYSICAL_ATTRIBUTES P ON B.OFFENDER_BOOK_ID = P.OFFENDER_BOOK_ID
           LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE AND RCE.DOMAIN = 'ETHNICITY'
           LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE AND RCS.DOMAIN = 'SEX'
     WHERE B.OFFENDER_BOOK_ID = :bookingId
           AND B.ACTIVE_FLAG = 'Y'
}

FIND_ACTIVE_APPROVED_ASSESSMENT {
  SELECT
    off_ass.OFFENDER_BOOK_ID AS BOOKING_ID,
    ass.ASSESSMENT_CODE,
    ass.DESCRIPTION          AS ASSESSMENT_DESCRIPTION,
    off_ass.review_sup_level_type,
    ref_review.DESCRIPTION   AS review_sup_level_type_desc,
    off_ass.overrided_sup_level_type,
    ref_override.DESCRIPTION AS overrided_sup_level_type_desc,
    off_ass.calc_sup_level_type,
    ref_cal_sup.DESCRIPTION  AS calc_sup_level_type_desc,
    ass.caseload_type,
    CASE WHEN ass.cell_sharing_alert_flag = 'Y' THEN 1 ELSE 0 END as cell_sharing_alert_flag,
    off_ass.assess_status,
    off_ass.assessment_date,
    off_ass.assessment_seq,
    off_ass.next_review_date
  FROM OFFENDER_ASSESSMENTS off_ass
    JOIN ASSESSMENTS ass ON off_ass.ASSESSMENT_TYPE_ID = ass.ASSESSMENT_ID
    LEFT JOIN REFERENCE_CODES ref_review
      ON off_ass.review_sup_level_type = ref_review.CODE AND ref_review.DOMAIN = 'SUP_LVL_TYPE'
    LEFT JOIN REFERENCE_CODES ref_override
      ON off_ass.overrided_sup_level_type = ref_override.CODE AND ref_override.DOMAIN = 'SUP_LVL_TYPE'
    LEFT JOIN REFERENCE_CODES ref_cal_sup
      ON off_ass.calc_sup_level_type = ref_cal_sup.CODE AND ref_cal_sup.DOMAIN = 'SUP_LVL_TYPE'
  WHERE off_ass.ASSESS_STATUS = 'A'
        AND off_ass.OFFENDER_BOOK_ID in (:bookingIds)
  ORDER BY ASSESSMENT_CODE, ASSESSMENT_DATE desc, ASSESSMENT_SEQ desc
  }

FIND_INMATE_ALIASES {
  SELECT O.LAST_NAME,
    O.FIRST_NAME,
    O.MIDDLE_NAME,
    O.BIRTH_DATE,
    RCE.DESCRIPTION AS ETHNICITY,
    RCS.DESCRIPTION AS SEX,
    RCNT.DESCRIPTION AS ALIAS_TYPE,
    O.CREATE_DATE
  FROM OFFENDERS O
    INNER JOIN OFFENDER_BOOKINGS OB ON O.ROOT_OFFENDER_ID = OB.ROOT_OFFENDER_ID
                                       AND O.OFFENDER_ID != OB.OFFENDER_ID
    LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE
                                     AND RCE.DOMAIN = 'ETHNICITY'
    LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE
                                     AND RCS.DOMAIN = 'SEX'
    LEFT JOIN REFERENCE_CODES RCNT ON O.ALIAS_NAME_TYPE = RCNT.CODE
                                      AND RCNT.DOMAIN = 'NAME_TYPE'
  WHERE OB.OFFENDER_BOOK_ID = :bookingId
}

FIND_MY_ASSIGNMENTS {
  SELECT B.OFFENDER_BOOK_ID,
         B.BOOKING_NO,
         O.OFFENDER_ID_DISPLAY,
         B.AGY_LOC_ID,
         O.FIRST_NAME,
         O.MIDDLE_NAME,
         O.LAST_NAME,
         O.BIRTH_DATE,
         (SELECT LISTAGG(ALERT_TYPE, ',')
          WITHIN GROUP (ORDER BY ALERT_TYPE)
          FROM (SELECT DISTINCT(ALERT_TYPE)
                FROM OFFENDER_ALERTS A
                WHERE B.OFFENDER_BOOK_ID = A.OFFENDER_BOOK_ID
                AND A.ALERT_STATUS = 'ACTIVE')) AS ALERT_TYPES,
         B.LIVING_UNIT_ID,
         AIL.DESCRIPTION AS LIVING_UNIT_DESC,
         (SELECT *
          FROM (SELECT IMAGE_ID
                FROM IMAGES
                WHERE ACTIVE_FLAG = 'Y'
                AND IMAGE_OBJECT_TYPE = 'OFF_BKG'
                AND IMAGE_OBJECT_ID = B.OFFENDER_BOOK_ID
                AND IMAGE_VIEW_TYPE = 'FACE'
                AND ORIENTATION_TYPE = 'FRONT'
                ORDER BY CREATE_DATETIME DESC)
          WHERE ROWNUM <= 1) AS FACE_IMAGE_ID
  FROM OFFENDER_BOOKINGS B
    INNER JOIN OFFENDERS O ON B.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON B.AGY_LOC_ID = C.AGY_LOC_ID AND C.CASELOAD_ID = :caseLoadId
    INNER JOIN STAFF_MEMBERS S ON B.ASSIGNED_STAFF_ID = S.STAFF_ID
    LEFT JOIN AGENCY_INTERNAL_LOCATIONS AIL ON B.LIVING_UNIT_ID = AIL.INTERNAL_LOCATION_ID
  WHERE B.ACTIVE_FLAG = 'Y'
  AND S.STAFF_ID = :staffId
}

FIND_PRISONERS {
  SELECT
    O.OFFENDER_ID_DISPLAY             OFFENDER_NO,
    UPPER(O.TITLE)                    TITLE,
    UPPER(O.SUFFIX)                   SUFFIX,
    UPPER(O.FIRST_NAME)               FIRST_NAME,
    UPPER(CONCAT(O.MIDDLE_NAME,
      CASE WHEN MIDDLE_NAME_2 IS NOT NULL
        THEN CONCAT(' ', O.MIDDLE_NAME_2)
      ELSE '' END))                   MIDDLE_NAMES,
    UPPER(O.LAST_NAME)                LAST_NAME,
    O.BIRTH_DATE                      DATE_OF_BIRTH,
    RCE.DESCRIPTION                   ETHNICITY,
    RCS.DESCRIPTION                   GENDER,
    RCC.DESCRIPTION                   BIRTH_COUNTRY,
    OB.BOOKING_BEGIN_DATE             RECEPTION_DATE,
    OB.ACTIVE_FLAG                    CURRENTLY_IN_PRISON,
    OB.AGY_LOC_ID                     LATEST_LOCATION_ID,
    AL.DESCRIPTION                    LATEST_LOCATION,
    COALESCE(ORD.RELEASE_DATE, ORD.AUTO_RELEASE_DATE) RELEASE_DATE,
    (SELECT OIS.IMPRISONMENT_STATUS
     FROM OFFENDER_IMPRISON_STATUSES OIS
     WHERE OIS.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
       AND OIS.IMPRISON_STATUS_SEQ = (SELECT MAX(OIS1.IMPRISON_STATUS_SEQ)
                                      FROM OFFENDER_IMPRISON_STATUSES OIS1
                                      WHERE OIS1.OFFENDER_BOOK_ID = OIS.OFFENDER_BOOK_ID)) IMPRISONMENT_STATUS
  FROM OFFENDERS O
    INNER JOIN OFFENDER_BOOKINGS OB ON OB.OFFENDER_ID = O.OFFENDER_ID
    INNER JOIN AGENCY_LOCATIONS AL ON AL.AGY_LOC_ID = OB.AGY_LOC_ID
    LEFT JOIN OFFENDER_RELEASE_DETAILS ORD ON ORD.OFFENDER_BOOK_ID = OB.OFFENDER_BOOK_ID
    LEFT JOIN REFERENCE_CODES RCE ON O.RACE_CODE = RCE.CODE AND RCE.DOMAIN = 'ETHNICITY'
    LEFT JOIN REFERENCE_CODES RCS ON O.SEX_CODE = RCS.CODE AND RCS.DOMAIN = 'SEX'
    LEFT JOIN REFERENCE_CODES RCC ON O.BIRTH_COUNTRY_CODE = RCC.CODE AND RCC.DOMAIN = 'COUNTRY'
}

LOCATION_FILTER_SQL {
    AIL.DESCRIPTION LIKE :locationPrefix
}
