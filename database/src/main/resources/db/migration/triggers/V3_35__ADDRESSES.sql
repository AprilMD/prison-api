CREATE OR REPLACE TRIGGER "ADDRESSES_TA"
BEFORE INSERT OR UPDATE OR DELETE ON ADDRESSES
REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
  DECLARE
    l_scn NUMBER;
    l_tid VARCHAR2(32);
  BEGIN
    /*
    ============================================================
       Generated by 2.3  Date Generation 10-NOV-2008
    ============================================================
      MODIFICATION HISTORY
       Person       Date      version      Comments
    -----------  --------- -----------  -------------------------------
        GJC      05/03/2007  2.3          Allow application setting some columns
        GJC      23/10/2006  2.2          Audit DELETE statements
       David Ng  18/04/2006  2.0.1        Audit column trigger
    */
    IF INSERTING
    THEN
      :NEW.create_datetime := NVL(:NEW.create_datetime, systimestamp);
      :NEW.create_user_id := NVL(:NEW.create_user_id, user);
    ELSIF UPDATING
      THEN
        :NEW.modify_datetime := systimestamp;
        :NEW.modify_user_id := user;
    END IF;
    IF NOT DELETING
    THEN
      :NEW.Audit_timestamp := systimestamp;
      :NEW.Audit_User_ID := SYS_CONTEXT('NOMIS', 'AUDIT_USER_ID', 30);
      :NEW.Audit_Module_Name := SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 65);
      :NEW.Audit_Client_User_ID := SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_USER_ID', 64);
      :NEW.Audit_Client_IP_Address := SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_IP_ADDRESS', 39);
      :NEW.Audit_Client_Workstation_Name := SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_WORKSTATION_NAME', 64);
      :NEW.Audit_Additional_Info := SYS_CONTEXT('NOMIS', 'AUDIT_ADDITIONAL_INFO', 256);
    ELSE
      l_tid := DBMS_TRANSACTION.local_transaction_id(create_transaction=>FALSE);
      SELECT current_scn
      INTO l_scn
      FROM v$database;
      INSERT INTO OMS_DELETED_ROWS
      (
        table_name,
        xid,
        scn,
        audit_timestamp,
        audit_user_id,
        audit_module_name,
        audit_client_user_id,
        audit_client_ip_address,
        audit_client_workstation_name,
        audit_additional_info
      )
      VALUES
        (
          'ADDRESSES',
          converttoxid(l_tid),
          l_scn,
          systimestamp,
          SYS_CONTEXT('NOMIS', 'AUDIT_USER_ID', 30),
          SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 65),
          SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_USER_ID', 64),
          SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_IP_ADDRESS', 39),
          SYS_CONTEXT('NOMIS', 'AUDIT_CLIENT_WORKSTATION_NAME', 64),
          SYS_CONTEXT('NOMIS', 'AUDIT_ADDITIONAL_INFO', 256)
        );
    END IF;
  END;

/



CREATE OR REPLACE TRIGGER "ADDRESSES_T3"
AFTER
INSERT OR DELETE OR UPDATE
  ON addresses
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
  DECLARE
    lv_agy_loc_id AGENCY_LOCATIONS.agy_loc_id%TYPE;
  BEGIN
    -- Lines added by GJC 21/12/2007 to check if the trigger code should be executed or not
    IF SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 50) = 'MERGE'
    THEN
      RETURN;
    END IF;
    -- Change added by GJC 21/12/2007 to check if the trigger code should be executed or not
    /* =========================================================
       Version Number = 2.1  Date Modified = 21-DEC-2007
       ========================================================= */

    /* MODIFICATION HISTORY
       Person      Date            Version       Comments
       ---------   ------       ------------  ------------------------------
       Graham      21-Dec-2007          2.1   #7775: Code added for Merge, fix versioning
       Patrick     27-JUN-2005    	    1.0   Initial Version

    */
    IF INSERTING
    THEN
      IF :NEW.OWNER_CLASS = 'AGY'
      THEN
        lv_agy_loc_id := :NEW.owner_code;
      END IF;
    ELSIF UPDATING OR DELETING
      THEN
        IF :OLD.OWNER_CLASS = 'AGY'
        THEN
          lv_agy_loc_id := :OLD.owner_code;
        END IF;
    END IF;

    IF lv_agy_loc_id IS NOT NULL
    THEN
      IF oumagyht.check_changed(:OLD.ADDRESS_TYPE, :NEW.ADDRESS_TYPE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'ADDRESS_TYPE', :OLD.ADDRESS_TYPE, :NEW.ADDRESS_TYPE,
                                                'NEW_ADDR_TYPE', 'REF_CODE');
      END IF;

      IF oumagyht.check_changed(:OLD.FLAT, :NEW.FLAT)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'FLAT', :OLD.FLAT, :NEW.FLAT, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.PREMISE, :NEW.PREMISE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'PREMISE', :OLD.PREMISE, :NEW.PREMISE, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.STREET, :NEW.STREET)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'STREET', :OLD.STREET, :NEW.STREET, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.LOCALITY, :NEW.LOCALITY)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'LOCALITY', :OLD.LOCALITY, :NEW.LOCALITY, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.CITY_CODE, :NEW.CITY_CODE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'CITY_CODE', :OLD.CITY_CODE, :NEW.CITY_CODE, 'CITY',
                                                'REF_CODE');
      END IF;

      IF oumagyht.check_changed(:OLD.COUNTY_CODE, :NEW.COUNTY_CODE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'COUNTY_CODE', :OLD.COUNTY_CODE, :NEW.COUNTY_CODE,
                                                'COUNTY', 'REF_CODE');
      END IF;

      IF oumagyht.check_changed(:OLD.POSTAL_CODE, :NEW.POSTAL_CODE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'POSTAL_CODE', :OLD.POSTAL_CODE, :NEW.POSTAL_CODE, '',
                                                '');
      END IF;

      IF oumagyht.check_changed(:OLD.COUNTRY_CODE, :NEW.COUNTRY_CODE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'COUNTRY_CODE', :OLD.COUNTRY_CODE, :NEW.COUNTRY_CODE,
                                                'COUNTRY', 'REF_CODE');
      END IF;

      IF oumagyht.check_changed(:OLD.VALIDATED_PAF_FLAG, :NEW.VALIDATED_PAF_FLAG)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'VALIDATED_PAF_FLAG', :OLD.VALIDATED_PAF_FLAG,
                                                :NEW.VALIDATED_PAF_FLAG, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.PRIMARY_FLAG, :NEW.PRIMARY_FLAG)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'PRIMARY_FLAG', :OLD.PRIMARY_FLAG, :NEW.PRIMARY_FLAG, '',
                                                '');
      END IF;

      IF oumagyht.check_changed(:OLD.MAIL_FLAG, :NEW.MAIL_FLAG)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'MAIL_FLAG', :OLD.MAIL_FLAG, :NEW.MAIL_FLAG, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.CAPACITY, :NEW.CAPACITY)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'CAPACITY', :OLD.CAPACITY, :NEW.CAPACITY, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.COMMENT_TEXT, :NEW.COMMENT_TEXT)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'COMMENT_TEXT', :OLD.COMMENT_TEXT, :NEW.COMMENT_TEXT, '',
                                                '');
      END IF;

      IF oumagyht.check_changed(:OLD.NO_FIXED_ADDRESS_FLAG, :NEW.NO_FIXED_ADDRESS_FLAG)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'NO_FIXED_ADDRESS_FLAG', :OLD.NO_FIXED_ADDRESS_FLAG,
                                                :NEW.NO_FIXED_ADDRESS_FLAG, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.SERVICES_FLAG, :NEW.SERVICES_FLAG)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'SERVICES_FLAG', :OLD.SERVICES_FLAG, :NEW.SERVICES_FLAG,
                                                '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.SPECIAL_NEEDS_CODE, :NEW.SPECIAL_NEEDS_CODE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'SPECIAL_NEEDS_CODE', :OLD.SPECIAL_NEEDS_CODE,
                                                :NEW.SPECIAL_NEEDS_CODE, 'LOCAL_AUTH', 'REF_CODE');
      END IF;

      IF oumagyht.check_changed(:OLD.CONTACT_PERSON_NAME, :NEW.CONTACT_PERSON_NAME)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'CONTACT_PERSON_NAME', :OLD.CONTACT_PERSON_NAME,
                                                :NEW.CONTACT_PERSON_NAME, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.BUSINESS_HOUR, :NEW.BUSINESS_HOUR)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'BUSINESS_HOUR', :OLD.BUSINESS_HOUR, :NEW.BUSINESS_HOUR,
                                                '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.START_DATE, :NEW.START_DATE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'START_DATE', :OLD.START_DATE, :NEW.START_DATE, '', '');
      END IF;

      IF oumagyht.check_changed(:OLD.END_DATE, :NEW.END_DATE)
      THEN
        oumagyht.insert_into_agy_loc_amendments(lv_agy_loc_id, 'END_DATE', :OLD.END_DATE, :NEW.END_DATE, '', '');
      END IF;
    END IF;
  END;

/



CREATE OR REPLACE TRIGGER "ADDRESSES_T1"
BEFORE
INSERT OR UPDATE
  ON addresses
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
  DECLARE V_numrows INTEGER;
  BEGIN
    /* =========================================================
       Version Number = 1.0  Date ModIFied = 06/21/2005
       ========================================================= */
    /* MODIFICATION HISTORY
       Person     	 Date      Version     	 Comments
       David Ng     06/21/2005  1.0          NOMIS new addresses table
    */
    IF :new.owner_class = 'OFF'
    THEN
      SELECT count(*)
      INTO v_numrows
      FROM offenders
      WHERE offender_id = :new.owner_id;
      IF (v_numrows = 0)
      THEN
        raise_application_error(
            -20001,
            'Cannot INSERT offender address record due to missing offender record.'
        );
      END IF;
    ELSIF :new.owner_class = 'PER'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM persons
        WHERE person_id = :new.owner_id;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT person address record due to missing person record.'
          );
        END IF;
    ELSIF :new.owner_class = 'CORP'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM corporates
        WHERE corporate_id = :new.owner_id;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT corporate address record due to missing corporate record.'
          );
        END IF;
    ELSIF :new.owner_class = 'STF'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM staff_members
        WHERE staff_id = :new.owner_id;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT staff address record due to missing staff record.'
          );
        END IF;
    ELSIF :new.owner_class = 'AGY'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM agency_locations
        WHERE agy_loc_id = :new.owner_code;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT agency address record due to missing location record.'
          );
        END IF;
    ELSIF :new.owner_class = 'OFF_EDU'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM offender_educations
        WHERE offender_book_id = :new.owner_id
              AND education_seq = :new.owner_seq;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT offender education address due to missing offender education record.'
          );
        END IF;
    ELSIF :new.owner_class = 'OFF_EMP'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM offender_employments
        WHERE offender_book_id = :new.owner_id
              AND employ_seq = :new.owner_seq;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT offender education address due to missing offender employment record.'
          );
        END IF;
    ELSIF :new.owner_class = 'PER_EMP'
      THEN
        SELECT count(*)
        INTO v_numrows
        FROM person_employments
        WHERE person_id = :new.owner_id
              AND employment_seq = :new.owner_seq;
        IF (v_numrows = 0)
        THEN
          raise_application_error(
              -20001,
              'Cannot INSERT offender education address due to missing person employment record.'
          );
        END IF;
    END IF;
  END;

/



CREATE OR REPLACE TRIGGER "ADDRESSES_T2"
AFTER
DELETE
  ON addresses
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
  DECLARE V_numrows INTEGER;
  BEGIN
    -- Lines added by GJC 21/12/2007 to check if the trigger code should be executed or not
    IF SYS_CONTEXT('NOMIS', 'AUDIT_MODULE_NAME', 50) = 'MERGE'
    THEN
      RETURN;
    END IF;
    -- Change added by GJC 21/12/2007 to check if the trigger code should be executed or not

    /* =========================================================
       Version Number = 2.2  Date ModIFied = 21-Dec-2007
       ========================================================= */
    /* MODIFICATION HISTORY
       Person     	 Date      Version     	 Comments
       ---------    ------     ---------  	 ------------------------------
       Graham	21/12/2007  2.2          #7775: Code added for Merge, fix versioning
       GJC          14/10/2006  2.1          Remove DBMS_OUTPUT call
       David Ng     06/21/2005  1.0          NOMIS new addresses table
    */
    SELECT count(*)
    INTO v_numrows
    FROM phones
    WHERE owner_Class = 'ADDR'
          AND Owner_id = :old.address_id;
    IF (v_numrows > 0)
    THEN
      raise_application_error(
          -20001,
          'Cannot DELETE the address record because address phone records exists.'
      );
    END IF;

    SELECT count(*)
    INTO v_numrows
    FROM internet_addresses
    WHERE owner_Class = 'ADDR'
          AND Owner_id = :old.address_id;
    IF (v_numrows > 0)
    THEN
      raise_application_error(
          -20001,
          'Cannot DELETE the address record because address internet addresses records exists.'
      );
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
    tag_error.handle();
  END;

/

