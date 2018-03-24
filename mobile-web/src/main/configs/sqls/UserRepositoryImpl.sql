FIND_ROLE_PASSWORD {
	SELECT PROFILE_VALUE ROLE_PWD
	  FROM %sSYSTEM_PROFILES
	 WHERE PROFILE_TYPE = 'SYS' AND PROFILE_CODE = 'ROLE_PSWD'
}

FIND_USER_BY_USERNAME {
  SELECT SM.STAFF_ID,
         SM.USER_ID               USERNAME,
         SM.FIRST_NAME,
         SM.LAST_NAME,
         SM.ASSIGNED_CASELOAD_ID  ACTIVE_CASE_LOAD_ID,
         (   SELECT INTERNET_ADDRESS
               FROM  INTERNET_ADDRESSES
              WHERE OWNER_CLASS = 'STF' AND INTERNET_ADDRESS_CLASS = 'EMAIL' AND OWNER_ID = SM.STAFF_ID
         ) EMAIL,
         (   SELECT MAX(IMAGE_ID)
               FROM IMAGES
              WHERE IMAGE_OBJECT_ID = SM.STAFF_ID AND IMAGE_OBJECT_TYPE = 'STAFF' AND ACTIVE_FLAG = 'Y'
         ) THUMBNAIL_ID
    FROM STAFF_MEMBERS SM
   WHERE SM.PERSONNEL_TYPE = 'STAFF'
     AND SM.USER_ID = :username
}

FIND_ROLES_BY_USERNAME {
  SELECT
    RL.ROLE_ID,
    REPLACE(RL.ROLE_CODE, '-', '_') ROLE_CODE,
    ROLE_NAME,
    PARENT_ROLE_CODE,
    NULL CASELOAD_ID
  FROM STAFF_MEMBERS SM
    INNER JOIN STAFF_MEMBER_ROLES RL ON SM.STAFF_ID = RL.STAFF_ID
    INNER JOIN OMS_ROLES RO ON RO.ROLE_ID = RL.ROLE_ID
  WHERE SM.PERSONNEL_TYPE = 'STAFF'
    AND SM.USER_ID = :username
}

UPDATE_STAFF_ACTIVE_CASE_LOAD {
	UPDATE STAFF_MEMBERS 
	   SET ASSIGNED_CASELOAD_ID = :caseLoadId
   WHERE STAFF_ID = :staffId
}

FIND_USER_BY_STAFF_ID_STAFF_USER_TYPE {
  SELECT SM.STAFF_ID,
         SM.USER_ID USERNAME,
         SM.FIRST_NAME,
         SM.LAST_NAME,
         SM.ASSIGNED_CASELOAD_ID ACTIVE_CASE_LOAD_ID,
         (SELECT INTERNET_ADDRESS
          FROM  INTERNET_ADDRESSES
          WHERE OWNER_CLASS = 'STF' AND INTERNET_ADDRESS_CLASS = 'EMAIL' AND OWNER_ID = SM.STAFF_ID) EMAIL,
         (SELECT MAX(IMAGE_ID)
          FROM IMAGES
          WHERE IMAGE_OBJECT_ID = SM.STAFF_ID AND IMAGE_OBJECT_TYPE = 'STAFF' AND ACTIVE_FLAG = 'Y') THUMBNAIL_ID
    FROM STAFF_MEMBERS SM
   WHERE SM.PERSONNEL_TYPE = 'STAFF'
     AND SM.STAFF_ID = :staffId
}
