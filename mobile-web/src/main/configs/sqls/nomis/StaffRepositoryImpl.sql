FIND_USER_BY_STAFF_ID {
  SELECT SM.STAFF_ID,
         SM.FIRST_NAME,
         SM.LAST_NAME,
         (SELECT IA.INTERNET_ADDRESS
          FROM INTERNET_ADDRESSES IA
          WHERE IA.OWNER_ID = SM.STAFF_ID
            AND IA.OWNER_CLASS = 'STF'
            AND IA.INTERNET_ADDRESS_CLASS = 'EMAIL') EMAIL,
         (SELECT TI.TAG_IMAGE_ID
          FROM TAG_IMAGES TI
          WHERE TI.IMAGE_OBJECT_ID = SM.STAFF_ID
            AND TI.IMAGE_OBJECT_TYPE = 'STAFF'
            AND TI.ACTIVE_FLAG = 'Y') THUMBNAIL_ID
  FROM STAFF_MEMBERS SM
  WHERE SM.STAFF_ID = :staffId
}

FIND_STAFF_BY_AGENCY_AND_ROLE {
  SELECT SLR.SAC_STAFF_ID                             STAFF_ID,
         SM.FIRST_NAME,
         SM.LAST_NAME,
         (SELECT IA.INTERNET_ADDRESS
            FROM INTERNET_ADDRESSES IA
           WHERE IA.OWNER_ID = SM.STAFF_ID
             AND IA.OWNER_CLASS = 'STF'
             AND IA.INTERNET_ADDRESS_CLASS = 'EMAIL') EMAIL,
         (SELECT TI.TAG_IMAGE_ID
            FROM TAG_IMAGES TI
           WHERE TI.IMAGE_OBJECT_ID = SM.STAFF_ID
             AND TI.IMAGE_OBJECT_TYPE = 'STAFF'
             AND TI.ACTIVE_FLAG = 'Y')                THUMBNAIL_ID,
         SLR.CAL_AGY_LOC_ID                           AGENCY_ID,
         AL.DESCRIPTION                               AGENCY_DESCRIPTION,
         SLR.FROM_DATE,
         SLR.TO_DATE,
         SLR.POSITION,
         RD1.DESCRIPTION                              POSITION_DESCRIPTION,
         SLR.ROLE,
         RD2.DESCRIPTION                              ROLE_DESCRIPTION,
         SLR.SCHEDULE_TYPE,
         RD3.DESCRIPTION                              SCHEDULE_TYPE_DESCRIPTION,
         SLR.HOURS_PER_WEEK
    FROM STAFF_LOCATION_ROLES SLR
      INNER JOIN STAFF_MEMBERS SM ON SLR.SAC_STAFF_ID = SM.STAFF_ID
      INNER JOIN AGENCY_LOCATIONS AL ON SLR.CAL_AGY_LOC_ID = AL.AGY_LOC_ID
      LEFT JOIN REFERENCE_CODES RD1 ON RD1.CODE = SLR.POSITION AND RD1.DOMAIN = 'STAFF_POS'
      LEFT JOIN REFERENCE_CODES RD2 ON RD2.CODE = SLR.ROLE AND RD2.DOMAIN = 'STAFF_ROLE'
      LEFT JOIN REFERENCE_CODES RD3 ON RD3.CODE = SLR.SCHEDULE_TYPE AND RD3.DOMAIN = 'SCHEDULE_TYP'
   WHERE SLR.CAL_AGY_LOC_ID = :agencyId
     AND SLR.ROLE = :role
     AND TRUNC(SYSDATE) BETWEEN TRUNC(SLR.FROM_DATE) AND TRUNC(COALESCE(SLR.TO_DATE,SYSDATE))
     AND SLR.FROM_DATE = (SELECT MAX(SLR2.FROM_DATE)
                            FROM STAFF_LOCATION_ROLES SLR2
                           WHERE SLR2.SAC_STAFF_ID = SLR.SAC_STAFF_ID
                             AND SLR2.CAL_AGY_LOC_ID = SLR.CAL_AGY_LOC_ID
                             AND SLR2.ROLE = SLR.ROLE)
}

FIND_STAFF_BY_AGENCY_POSITION_ROLE {
  SELECT SLR.SAC_STAFF_ID                             STAFF_ID,
         SM.FIRST_NAME,
         SM.LAST_NAME,
         (SELECT IA.INTERNET_ADDRESS
            FROM INTERNET_ADDRESSES IA
           WHERE IA.OWNER_ID = SM.STAFF_ID
             AND IA.OWNER_CLASS = 'STF'
             AND IA.INTERNET_ADDRESS_CLASS = 'EMAIL') EMAIL,
         (SELECT TI.TAG_IMAGE_ID
            FROM TAG_IMAGES TI
           WHERE TI.IMAGE_OBJECT_ID = SM.STAFF_ID
             AND TI.IMAGE_OBJECT_TYPE = 'STAFF'
             AND TI.ACTIVE_FLAG = 'Y')                THUMBNAIL_ID,
         SLR.CAL_AGY_LOC_ID                           AGENCY_ID,
         AL.DESCRIPTION                               AGENCY_DESCRIPTION,
         SLR.FROM_DATE,
         SLR.TO_DATE,
         SLR.POSITION,
         RD1.DESCRIPTION                              POSITION_DESCRIPTION,
         SLR.ROLE,
         RD2.DESCRIPTION                              ROLE_DESCRIPTION,
         SLR.SCHEDULE_TYPE,
         RD3.DESCRIPTION                              SCHEDULE_TYPE_DESCRIPTION,
         SLR.HOURS_PER_WEEK
    FROM STAFF_LOCATION_ROLES SLR
      INNER JOIN STAFF_MEMBERS SM ON SLR.SAC_STAFF_ID = SM.STAFF_ID
      INNER JOIN AGENCY_LOCATIONS AL ON SLR.CAL_AGY_LOC_ID = AL.AGY_LOC_ID
      LEFT JOIN REFERENCE_CODES RD1 ON RD1.CODE = SLR.POSITION AND RD1.DOMAIN = 'STAFF_POS'
      LEFT JOIN REFERENCE_CODES RD2 ON RD2.CODE = SLR.ROLE AND RD2.DOMAIN = 'STAFF_ROLE'
      LEFT JOIN REFERENCE_CODES RD3 ON RD3.CODE = SLR.SCHEDULE_TYPE AND RD3.DOMAIN = 'SCHEDULE_TYP'
   WHERE SLR.CAL_AGY_LOC_ID = :agencyId
     AND SLR.POSITION = :position
     AND SLR.ROLE = :role
     AND TRUNC(SYSDATE) BETWEEN TRUNC(SLR.FROM_DATE) AND TRUNC(COALESCE(SLR.TO_DATE,SYSDATE))
     AND SLR.FROM_DATE = (SELECT MAX(SLR2.FROM_DATE)
                            FROM STAFF_LOCATION_ROLES SLR2
                           WHERE SLR2.SAC_STAFF_ID = SLR.SAC_STAFF_ID
                             AND SLR2.CAL_AGY_LOC_ID = SLR.CAL_AGY_LOC_ID
                             AND SLR2.POSITION = SLR.POSITION
                             AND SLR2.ROLE = SLR.ROLE)
}