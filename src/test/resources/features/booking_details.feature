Feature: Booking Details

  Acceptance Criteria:
  A logged in staff user can retrieve correct booking details for a provided offender booking id.

  Background:
    Given a user has authenticated with the API

  Scenario Outline: Request for specific offender booking record - assigned officer, CSRA and category
    When an offender booking request is made with booking id "<bookingId>"
    Then booking number of offender booking returned is "<bookingNo>"
    And assigned officer id of offender booking returned is "<assignedOfficerId>"
    And the CSRA is "<csra>"
    And the category is "<category>"

    Examples:
      | bookingId | bookingNo | assignedOfficerId | csra | category |
      | -1        | A00111    | -1                | High | Low      |
      | -2        | A00112    | -1                |      |          |
      | -3        | A00113    | -1                | Low  |          |
      | -8        | A00118    | -1                |      |          |

  Scenario Outline: Request for specific offender booking record basic details only
    When a basic offender booking request is made with booking id "<bookingId>"
    Then booking number of offender booking returned is "<bookingNo>"
    And firstname of offender booking returned is "<firstName>"
    And lastName of offender booking returned is "<lastName>"
    And offenderNo of offender booking returned is "<offenderNo>"
    And activeFlag of offender booking returned is "<activeFlag>"

    Examples:
      | bookingId | bookingNo | firstName | lastName | offenderNo | activeFlag |
      | -1        | A00111    | ARTHUR    | ANDERSON | A1234AA    | true       |
      | -2        | A00112    | GILLIAN   | ANDERSON | A1234AB    | true       |


  Scenario Outline: Request for specific offender booking record - physical attributes
    When an offender booking request is made with booking id "<bookingId>"
    Then booking number of offender booking returned is "<bookingNo>"
    And gender matches "<gender>"
    And ethnicity matches "<ethnicity>"
    And height in feet matches "<ft>"
    And height in inches matches "<in>"
    And height in centimetres matches "<cm>"
    And height in metres matches "<m>"
    And weight in pounds matches "<lb>"
    And weight in kilograms matches "<kg>"

    Examples:
      | bookingId | bookingNo | gender | ethnicity                      | ft | in | cm  | m    | lb  | kg  |
      | -1        | A00111    | Male   | White: British                 | 5  | 6  | 168 | 1.68 | 165 | 75  |
      | -2        | A00112    | Female | White: Irish                   |    |    |     |      | 120 | 55  |
      | -3        | A00113    | Male   | White: British                 | 5  | 10 | 178 | 1.78 |     |     |
      | -4        | A00114    | Male   | White: British                 | 6  | 1  | 185 | 1.85 | 218 | 99  |
      | -5        | A00115    | Male   | White: British                 | 6  | 0  | 183 | 1.83 | 190 | 86  |
      | -6        | A00116    | Male   | White: British                 | 6  | 2  | 188 | 1.88 |     |     |
      | -7        | A00117    | Male   | White: British                 | 5  | 11 | 180 | 1.80 | 196 | 89  |
      | -8        | A00118    | Male   | White: British                 | 5  | 11 | 180 | 1.80 |     |     |
      | -9        | A00119    | Male   | Mixed: White and Black African | 5  | 10 | 178 | 1.78 | 185 | 84  |
      | -10       | A00120    | Male   | White: British                 | 6  | 6  | 198 | 1.98 | 235 | 107 |

  Scenario Outline: Request for specific offender booking record - physical characteristics
    When an offender booking request is made with booking id "<bookingId>"
    Then booking number of offender booking returned is "<bookingNo>"
    And characteristics match "<characteristicsList>"

    Examples:
      | bookingId | bookingNo | characteristicsList                      |
      | -1        | A00111    | Right Eye Colour=Blue,Shape of Face=Oval |
      | -2        | A00112    | Shape of Face=Round                      |
      | -3        | A00113    | Shoe Size=8                              |
      | -4        | A00114    | Shoe Size=10                             |
      | -5        | A00115    |                                          |
      | -7        | A00117    | Left Eye Colour=Hazel                    |
      | -10       | A00120    | Complexion=Fair                          |
      | -11       | A00121    | Hair Colour=Brunette,Complexion=Blotched |
      | -12       | A00122    | Hair Colour=Bald                         |

  Scenario: Request for specific offender booking record that does not exist
    When an offender booking request is made with booking id "-9999"
    Then resource not found response is received from bookings API

  Scenario: Request for specific offender inactive booking record
    When a basic offender booking request is made with booking id "-13"
    Then resource not found response is received from bookings API

  Scenario: Request for specific offender as system user can return data even though booking is inactive
    When a user has a token name of "SYSTEM_USER_READ_WRITE"
    When an offender booking request is made with booking id "-13"
    Then booking number of offender booking returned is "A00123"

  Scenario: Request for specific offender as user with Inactive Booking Role can return data even though booking is inactive
    When a user has a token name of "INACTIVE_BOOKING_USER"
    When an offender booking request is made with booking id "-13"
    Then booking number of offender booking returned is "A00123"

  Scenario Outline: Request for assessment information about an offender
    When an offender booking assessment information request is made with booking id <bookingId> and "<assessmentCode>"
    Then the classification is "<classification>"
    And the Cell Sharing Alert is <CSRA>
    And the Next Review Date is "<nextReviewDate>"

    Examples:
      | bookingId | assessmentCode | CSRA  | classification | nextReviewDate |
      | -1        | CSR            | true  | High           | 2018-06-01     |
      | -2        | CSR            | true  |                | 2018-06-02     |
      | -3        | CSR            | true  | Low            | 2018-06-03     |
      | -4        | CSR            | true  | Medium         | 2018-06-04     |
      | -5        | CSR            | true  | High           | 2018-06-05     |
      | -6        | CATEGORY       | false | Cat C          | 2018-06-07     |
      | -6        | CSR            | true  | Standard       | 2018-06-06     |
      | -6        | PAROLE         | false | High           | 2018-06-08     |

  Scenario: Request for assessment information for booking that does not have requested assessment
    When an offender booking assessment information request is made with booking id -9 and "CSR"
    Then resource not found response is received from booking assessments API
    And user message in resource not found response from booking assessments API is "Offender does not have a [CSR] assessment on record."

  Scenario: Request for assessment information for booking that does not exist
    When an offender booking assessment information request is made with booking id -99 and "CSR"
    Then resource not found response is received from booking assessments API

  Scenario: Request for assessment information for booking that is not part of any of logged on staff user's caseloads
    When an offender booking assessment information request is made with booking id -16 and "CSR"
    Then resource not found response is received from booking assessments API

  Scenario: Request for CSR assessment information for multiple offenders
    When an offender booking assessment information request is made with offender numbers "A1234AA,A1234AB,A1234AC,A1234AD,A1234AE,A1234AF,A1234AG,A1234AP,NEXIST" and "CSR" and latest="false"
    Then correct results are returned as for single assessment

  Scenario: Request for category assessment information for multiple offenders
    When an offender booking assessment information request is made with offender numbers "A1234AE,A1234AF" and "CATEGORY" and latest="false"
    Then full category history is returned

  Scenario: Request for CSR assessment information for multiple offenders (using post request which allows large sets of offenders)
    When an offender booking assessment information POST request is made with offender numbers "A1234AA,A1234AB,A1234AC,A1234AD,A1234AE,A1234AF,A1234AG,A1234AP,NEXIST" and "CSR"
    Then correct results are returned as for single assessment

  Scenario: Request for assessment information with empty list of offenders (using post request which allows large sets of offenders)
    When an offender booking assessment information POST request is made with offender numbers "" and "CSR"
    Then bad request response is received from booking assessments API with message "List of Offender Ids must be provided"

  Scenario: Request for CSRAs for multiple offenders (using post request which allows large sets of offenders)
    When an offender booking CSRA information POST request is made with offender numbers "A1234AA,A1234AB,A1234AC,A1234AD,A1234AE,A1234AF,A1234AG,A1234AP,NEXIST"
    Then correct results are returned as for single assessment

  Scenario: Request for offenders who need to be categorised
    When a request is made for uncategorised offenders at "MDI"
    Then 2 uncategorised offenders are returned

  Scenario: Request for offenders who need to be categorised with invalid agency
    When a request is made for uncategorised offenders at "XXXX"
    Then resource not found response is received from booking assessments API

  Scenario: Request for offenders who have an approved categorisation
    When a request is made for categorised offenders at "LEI" with an approval from Date of "2018-02-02"
    Then 1 categorised offenders are returned

  Scenario: Request for offenders who have an approved categorisation using default 1 month period
    When a request is made for categorised offenders at "LEI" with an approval from Date of ""
    Then 0 categorised offenders are returned

  Scenario: Request for offender categorisation details for given booking ids
    When a request is made for offender categorisation details at "LEI" with booking id "-31"
    Then 1 categorised offenders are returned

  Scenario: Request for offender categorisation details for given booking ids that do not match the given agency
    When a request is made for offender categorisation details at "MDI" with booking id "-31"
    Then 0 categorised offenders are returned

  Scenario: Create categorisation request
    Given a categorisation user has authenticated with the API
    When a categorisation request is made for booking "-35" with category "D" for committee "RECP"
    And a request is made for uncategorised offenders at "MDI"
    Then offender with booking "-35" has a categorised status of AWAITING_APROVAL
@lucy
  Scenario: Approve categorisation
    Given a user has a token name of "CATEGORISATION_APPROVE"
    And a request is made for uncategorised offenders at "LEI"
    And offender with booking "-34" has a categorised status of AWAITING_APROVAL
    When a categorisation is approved for booking "-34" with category "D" date "2019-02-28" and comment "Make it so"
    And a request is made for uncategorised offenders at "LEI"
    Then offender with booking "-34" is not present

  Scenario: Approve categorisation validation: no auth
    When a categorisation is approved for booking "-34" with category "D" date "2019-02-28" and comment "Make it so"
    Then access denied response is received from booking assessments API

  Scenario: Approve categorisation validation: no category
    Given a user has a token name of "CATEGORISATION_APPROVE"
    When a categorisation is approved for booking "-34" with category "" date "2019-02-28" and comment "Make it so"
    Then bad request response is received from booking assessments API with message "category must be provided"

  Scenario: Approve categorisation validation: no booking
    Given a user has a token name of "CATEGORISATION_APPROVE"
    When a categorisation is approved for booking "" with category "C" date "2019-02-28" and comment "Make it so"
    Then bad request response is received from booking assessments API with message "bookingId must be provided"

  Scenario: Approve categorisation validation: invalid booking
    Given a user has a token name of "CATEGORISATION_APPROVE"
    When a categorisation is approved for booking "-999" with category "C" date "2019-02-28" and comment ""
    Then resource not found response is received from booking assessments API

  Scenario: Approve categorisation validation: no date
    Given a user has a token name of "CATEGORISATION_APPROVE"
    When a categorisation is approved for booking "-34" with category "B" date "" and comment ""
    Then bad request response is received from booking assessments API with message "Date of approval must be provided"

  Scenario: Approve categorisation validation: invalid category
    Given a user has a token name of "CATEGORISATION_APPROVE"
    When a categorisation is approved for booking "-34" with category "hmm" date "2019-02-28" and comment ""
    Then bad request response is received from booking assessments API with message "Category not recognised."

  Scenario: Approve categorisation validation: no pending category exists
    Given a user has a token name of "CATEGORISATION_APPROVE"
    When a categorisation is approved for booking "-33" with category "C" date "2019-02-28" and comment ""
    Then bad request response is received from booking assessments API with message "No category assessment found, category C, booking -33"

  Scenario Outline: Request for specific offender booking record returns language
    When an offender booking request is made with booking id "<bookingId>"
    Then language of offender booking returned is "<language>"

    Examples:
      | bookingId | language |
      | -1        | Polish   |
      | -2        | Polish   |
      | -3        | Turkish  |
      | -4        |          |
      | -7        |          |

  Scenario Outline: When requesting offender details a count of active and inactive alerts are returned
    When an offender booking request is made with booking id "<bookingId>"
    Then the number of active alerts is <activeAlerts>
    And the number of inactive alerts is <inactiveAlerts>
    And the list of active alert types is "<alertTypes>"

    Examples:
      | bookingId | activeAlerts | inactiveAlerts | alertTypes |
      | -1        | 2            | 1              | H,X        |
      | -2        | 1            | 0              | H          |
      | -11       | 0            | 0              |            |

  Scenario: Request for assessment data
    When assessment information is requested for Booking Id "-6"
    Then "3" row of assessment data is returned

  Scenario Outline: Request for physical attributes
    When an physical attributes request is made with booking id "<bookingId>"
    And gender matches "<gender>"
    And ethnicity matches "<ethnicity>"
    And height in feet matches "<ft>"
    And height in inches matches "<in>"
    And height in centimetres matches "<cm>"
    And height in metres matches "<m>"
    And weight in pounds matches "<lb>"
    And weight in kilograms matches "<kg>"

  Examples:
    | bookingId | gender | ethnicity                      | ft | in | cm  | m    | lb  | kg  |
    | -1        | Male   | White: British                 | 5  | 6  | 168 | 1.68 | 165 | 75  |
    | -2        | Female | White: Irish                   |    |    |     |      | 120 | 55  |
    | -3        | Male   | White: British                 | 5  | 10 | 178 | 1.78 |     |     |
    | -4        | Male   | White: British                 | 6  | 1  | 185 | 1.85 | 218 | 99  |
    | -5        | Male   | White: British                 | 6  | 0  | 183 | 1.83 | 190 | 86  |
    | -6        | Male   | White: British                 | 6  | 2  | 188 | 1.88 |     |     |
    | -7        | Male   | White: British                 | 5  | 11 | 180 | 1.80 | 196 | 89  |
    | -8        | Male   | White: British                 | 5  | 11 | 180 | 1.80 |     |     |
    | -9        | Male   | Mixed: White and Black African | 5  | 10 | 178 | 1.78 | 185 | 84  |
    | -10       | Male   | White: British                 | 6  | 6  | 198 | 1.98 | 235 | 107 |

 Scenario: Request for offender identifiers
    When offender identifiers are requested for Booking Id "-4"
    Then "1" row of offender identifiers is returned

  Scenario: Request for profile information
    When profile information is requested for Booking Id "-1"
    Then correct profile information is returned

  Scenario: Request for physical characteristics
    When physical characteristic information is requested for Booking Id "-1"
    Then "2" row of physical characteristics is returned

  Scenario: Request for image metadata
    When image metadata is requested for Booking Id "-1"
    Then image data is returned

    Scenario Outline: Request offender basic details by offender numbers
      When a request is made for  "A1234AE,A1234AB"
      Then data is returned that includes "<firstName>" "<lastName>" "<middleName>" "<offenderNo>" "<bookingId>" "<agencyId>"

      Examples:
      | firstName | lastName   | middleName     | offenderNo   | bookingId | agencyId |
      | Donald    | Duck       | Jeffrey Robert | A1234AE      | -5        | LEI      |
      | Gillian   | Anderson   | Eve            | A1234AB      | -2        | LEI      |
