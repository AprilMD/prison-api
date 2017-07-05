@global
Feature: Users and Staff

  Acceptance Criteria:
  A logged in user can find staff details for any valid staff id

  Background:
    Given a user has authenticated with the API

  Scenario Outline: Find staff member using staff id
    When a staff member search is made using staff id "<staffId>"
    Then first name of staff details returned is "<firstName>"
    And last name of staff details returned is "<lastName>"
    And email address of staff details returned is "<email>"

    Examples:
      | staffId | firstName | lastName | email                      |
      | -1      | ELITE2    | USER     | elite2-api-user@syscon.net |
      | -2      | API       | USER     | itaguser@syscon.net        |

  Scenario: Find staff member using staff id that does not exist
    When a staff member search is made using staff id "9999999999"
    Then http status "404" response is returned