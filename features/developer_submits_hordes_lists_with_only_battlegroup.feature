Feature: developer submits a battlegroup-only, Hordes War Room list

  As a developer
  I want to parse War Room Hordes lists with only a battlegroup
  So that I can use the data in my other programs


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


  Scenario: warlock with a warlock attachment
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


  Scenario: warlock with a warlock attachment and a 'beast
    Given a list of:
      """
      War Room Army

      Trollblood - New Army

      12 / 21 (15+6)    Warlock(s) : 1/1    Warbeast(s) : 1    Battle Engines : 0    Solos : 0    Units : 0

      Borka, Vengeance of the Rimeshaws - WB: +6
      -    Trollkin Runebearer
      -    Earthborn Dire Troll - PC: 10

      ---

      GENERATED : 11/10/2014 17:33:57
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: warlock with a warlock attachment and 2 'beasts
    Given a list of:
      """
      War Room Army

      Trollblood - New Army

      21 / 21 (15+6)    Warlock(s) : 1/1    Warbeast(s) : 2    Battle Engines : 0    Solos : 0    Units : 0

      Borka, Vengeance of the Rimeshaws - WB: +6
      -    Trollkin Runebearer
      -    Earthborn Dire Troll - PC: 10
      -    Dozer & Smigg - PC: 9

      ---

      GENERATED : 11/10/2014 17:33:36
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: warlock with a 'beast attachment
    Given a list of:
      """
      War Room Army

      Circle Orboros - hordes battlegroup

      0 / 18 (15+3)    Warlock(s) : 1/1    Warbeast(s) : 1    Battle Engines : 0    Solos : 0    Units : 0

      Kaya the Moonhunter - WB: +3

      ---

      GENERATED : 11/10/2014 18:04:27
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: warlock with a 'beast attachment and another 'beast
    Given a list of:
      """
      War Room Army

      Circle Orboros - hordes battlegroup

      9 / 18 (15+3)    Warlock(s) : 1/1    Warbeast(s) : 2    Battle Engines : 0    Solos : 0    Units : 0

      Kaya the Moonhunter - WB: +3
      -    Feral Warpwolf - PC: 9

      ---

      GENERATED : 11/10/2014 18:04:49
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: warlock with a 'beast pack
    Given a list of:
      """
      War Room Army

      Legion of Everblight - New Army

      4 / 20 (15+5)    Warlock(s) : 1/1    Warbeast(s) : 1    Battle Engines : 0    Solos : 0    Units : 0

      Absylonia, Terror of Everblight - WB: +5
      -    Blight Wasps - PC: 4

      ---

      GENERATED : 11/10/2014 18:10:10
      """
    When I parse the list
    Then I should get a parsed list
