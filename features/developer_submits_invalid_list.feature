Feature: developer submits an invalid list

  As a developer
  I want to throw an exception when parsing invalid War Room lists
  So that I am aware of mistakes


  Scenario: empty string
    Given a list of:
      """
      """
    When I parse the list
    Then an InvalidListException should be thrown


  Scenario: invalid list
    Given a list of:
      """
      War Room Ar
      """
    When I parse the list
    Then an InvalidListException should be thrown


  Scenario: empty list
    Given a list of:
      """
      War Room Army

      Khador - empty list

      0 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

      ---

      GENERATED : 11/09/2014 10:46:12
      """
    When I parse the list
    Then an InvalidListException should be thrown
