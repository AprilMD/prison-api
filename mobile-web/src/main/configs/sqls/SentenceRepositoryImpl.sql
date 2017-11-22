GET_BOOKING_MAIN_OFFENCES {
  SELECT OCH.OFFENDER_BOOK_ID BOOKING_ID,
         OFFS.DESCRIPTION OFFENCE_DESCRIPTION
  FROM OFFENDER_CHARGES OCH
    INNER JOIN OFFENCES OFFS ON OFFS.OFFENCE_CODE = OCH.OFFENCE_CODE AND OFFS.STATUTE_CODE = OCH.STATUTE_CODE
  WHERE OCH.OFFENDER_BOOK_ID = :bookingId
    AND OCH.MOST_SERIOUS_FLAG = 'Y'
    AND OCH.CHARGE_STATUS = 'A'
  ORDER BY CAST(COALESCE(OFFS.SEVERITY_RANKING, '999') AS INT)
}

GET_BOOKING_CONFIRMED_RELEASE_DATE {
  SELECT RELEASE_DATE
  FROM OFFENDER_RELEASE_DETAILS
  WHERE OFFENDER_BOOK_ID = :bookingId
}

GET_CASE {
  -- not currently used, this gets a case id for the query below
SELECT ocs.case_id,
       ocs.case_info_number,
       ocs.begin_date,
       ocs.case_status,
       ocs.agy_loc_id court_code,
        al.description court_desc,
       ocs.case_type case_type_code,
       rc.description case_type_desc
  FROM offender_cases ocs
       JOIN agency_locations al ON al.agy_loc_id = ocs.agy_loc_id
  LEFT JOIN reference_codes rc  ON rc.code = ocs.case_type AND rc.domain = 'LEG_CASE_TYP'
 WHERE ocs.offender_book_id = :offenderBookingId
 ORDER BY ocs.case_status asc, ocs.begin_date desc
}

GET_CHARGES {
  -- not currently used, this services the 'old API' /offenders/<noms_id>/charges call
SELECT och.offender_charge_id,
       och.statute_code,
       och.offence_code,
       och.no_of_offences,
       och.most_serious_flag,
       och.charge_status,
       offs.severity_ranking,
       offs.description offence_desc,
       s.description statute_desc,
       orc.result_code,
       orc.description result_desc,
       orc.disposition_code,
       r1.description disposition_desc,
       orc.conviction_flag,
       ist.imprisonment_status,
       ist.description imprisonment_status_desc,
       ist.band_code,
       r2.description band_desc
  FROM offender_charges och
       JOIN offences offs                ON offs.offence_code = och.offence_code AND offs.statute_code = och.statute_code
       JOIN statutes s                   ON s.statute_code = offs.statute_code
  LEFT JOIN offence_result_codes orc     ON och.result_code_1 = orc.result_code
  LEFT JOIN reference_codes r1           ON r1.code = orc.disposition_code AND r1.domain = 'OFF_RESULT'
  LEFT JOIN imprison_status_mappings ism ON ism.offence_result_code = orc.result_code
  LEFT JOIN imprisonment_statuses ist    ON ist.imprisonment_status_id = ism.imprisonment_status_id
  LEFT JOIN reference_codes r2           ON r2.code = ist.band_code AND r2.domain = 'IMPSBAND'
 WHERE och.case_id = :caseId
 ORDER BY och.charge_status asc, och.most_serious_flag desc, offs.severity_ranking
}
