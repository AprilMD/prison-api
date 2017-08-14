FIND_AGENCY {
    SELECT A.AGY_LOC_ID,
           A.DESCRIPTION,
           A.AGENCY_LOCATION_TYPE
      FROM AGENCY_LOCATIONS A JOIN CASELOAD_AGENCY_LOCATIONS C
         ON A.AGY_LOC_ID = C.AGY_LOC_ID
     WHERE A.ACTIVE_FLAG = 'Y'
           AND A.AGY_LOC_ID NOT IN ('OUT', 'TRN')
           AND A.AGY_LOC_ID = :agencyId
           AND C.CASELOAD_ID = :caseLoadId
}

FIND_AGENCIES_BY_CASELOAD {
    SELECT A.AGY_LOC_ID,
           A.DESCRIPTION,
           A.AGENCY_LOCATION_TYPE
    FROM AGENCY_LOCATIONS A
        INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON A.AGY_LOC_ID = C.AGY_LOC_ID
    WHERE A.ACTIVE_FLAG = 'Y'
      AND A.AGY_LOC_ID NOT IN ('OUT', 'TRN')
      AND C.CASELOAD_ID = :caseLoadId
}

FIND_AGENCIES_BY_USERNAME {
    SELECT DISTINCT A.AGY_LOC_ID,
           A.DESCRIPTION,
           A.AGENCY_LOCATION_TYPE
    FROM AGENCY_LOCATIONS A
        INNER JOIN CASELOAD_AGENCY_LOCATIONS C ON A.AGY_LOC_ID = C.AGY_LOC_ID
    WHERE A.ACTIVE_FLAG = 'Y'
      AND A.AGY_LOC_ID NOT IN ('OUT', 'TRN')
      AND C.CASELOAD_ID IN (
          SELECT SAC.CASELOAD_ID
          FROM STAFF_ACCESSIBLE_CASELOADS SAC
              INNER JOIN STAFF_MEMBERS SM ON SM.STAFF_ID = SAC.STAFF_ID
                  AND SM.PERSONNEL_TYPE = 'STAFF' AND SM.USER_ID = :username)
}
