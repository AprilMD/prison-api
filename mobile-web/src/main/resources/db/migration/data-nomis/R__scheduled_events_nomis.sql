-- For NOMIS, include SLOT_CATEGORY_CODE value in COURSE_SCHEDULES records (this column not in Elite Core schema).
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -1;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -2;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -3;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -4;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -5;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -6;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -7;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -8;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -9;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -10;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -11;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -12;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -13;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -14;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'PM' WHERE CRS_SCH_ID = -15;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -16;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -17;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -18;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -19;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -20;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -21;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -22;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -23;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -24;
UPDATE COURSE_SCHEDULES SET SLOT_CATEGORY_CODE = 'AM' WHERE CRS_SCH_ID = -25;

-- OFFENDER_EXCLUDE_ACTS_SCHDS (record of offenders being excluded from scheduled activities)
INSERT INTO OFFENDER_EXCLUDE_ACTS_SCHDS (OFFENDER_EXCLUDE_ACT_SCHD_ID, OFFENDER_BOOK_ID, OFF_PRGREF_ID, CRS_ACTY_ID, EXCLUDE_DAY, SLOT_CATEGORY_CODE)
  VALUES (-1, -4, -7, -4, 'FRI', null),
         (-2, -5, -8, -1, 'MON', 'AM'),
         (-3, -5, -8, -1, 'TUE', 'PM');

-- ADDRESSES (PREMISE column does not exist in Elite Core schema)
UPDATE ADDRESSES SET PREMISE = 'Birmingham Youth Court' WHERE ADDRESS_ID = -1;
UPDATE ADDRESSES SET PREMISE = 'The Court House' WHERE ADDRESS_ID = -2;