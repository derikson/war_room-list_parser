Feature: developer submits a valid list

  As a developer
  I want to parse valid War Room lists
  So that I can use the data in my other programs


  Scenario: warcaster only
    Given a list of:
      """
      War Room Army

      Khador - New Army

      0 / 21 (15+6)    Warcaster(s) : 1/1    Warjack(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

      Forward Kommander Sorscha - WJ: +6

      ---

      GENERATED : 11/10/2014 02:02:30
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: warlock only
    Given a list of:
      """
      War Room Army

      Trollblood - New Army

      0 / 21 (15+6)    Warlock(s) : 1/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

      Borka, Vengeance of the Rimeshaws - WB: +6

      ---

      GENERATED : 11/10/2014 02:07:03
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: warlock with free warlock attachment
    Given a list of:
      """
      War Room Army

      Trollblood - New Army

      0 / 20 (15+5)    Warlock(s) : 1/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

      Borka Kegslayer - WB: +5
      -    Pyg Keg Carrier

      ---

      GENERATED : 11/10/2014 02:09:03
      """
    When I parse the list
    Then I should get a parsed list
