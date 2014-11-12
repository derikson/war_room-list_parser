Feature: developer submits a battlegroup-only, Warmachine War Room list

  As a developer
  I want to parse War Room Warmachine lists with only a battlegroup
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
    And I should get 1 warnoun
    And I should not get a warnoun attachment
    And I should get 0 warbjs
    And I should get 0 battle engines
    And I should get 0 solos
    And I should get 0 units
    And I should get 0 unit attachments


  Scenario: warcaster with a warcaster attachment
    Given a list of:
      """
      War Room Army

      Cryx - warmachine battlegroup

      0 / 19 (15+4)    Warcaster(s) : 1/1    Warjack(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

      Master Necrotech Mortenebra - WJ: +4
      -    Deryliss

      ---

      GENERATED : 11/10/2014 17:54:53
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should get a warnoun attachment
    And I should get 0 warbjs


  Scenario: warcaster with a warcaster attachment and a 'jack
    Given a list of:
      """
      War Room Army

      Cryx - warmachine battlegroup

      5 / 19 (15+4)    Warcaster(s) : 1/1    Warjack(s) : 1    Battle Engines : 0    Solos : 1    Units : 0

      Master Necrotech Mortenebra - WJ: +4
      -    Deryliss
      -    Cankerworm - PC: 5

      ---

      GENERATED : 11/10/2014 17:56:57
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should get a warnoun attachment
    And I should get 1 warbj


  Scenario: warcaster with a warcaster attachment and 2 'jacks
    Given a list of:
      """
      War Room Army

      Cryx - warmachine battlegroup

      9 / 19 (15+4)    Warcaster(s) : 1/1    Warjack(s) : 2    Battle Engines : 0    Solos : 1    Units : 0

      Master Necrotech Mortenebra - WJ: +4
      -    Deryliss
      -    Cankerworm - PC: 5
      -    Deathripper - PC: 4

      ---

      GENERATED : 11/10/2014 17:57:16
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should get a warnoun attachment
    And I should get 2 warbjs


  Scenario: warcaster with a 'jack attachment
    Given a list of:
      """
      War Room Army

      Khador - warmachine battlegroup

      0 / 18 (15+3)    Warcaster(s) : 1/1    Warjack(s) : 1    Battle Engines : 0    Solos : 0    Units : 0

      The Old Witch of Khador - WJ: +3

      ---

      GENERATED : 11/10/2014 18:03:01
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should not get a warnoun attachment
    And I should get 0 warbjs


  Scenario: warcaster with a 'jack attachment and another 'jack
    Given a list of:
      """
      War Room Army

      Khador - warmachine battlegroup

      13 / 18 (15+3)    Warcaster(s) : 1/1    Warjack(s) : 2    Battle Engines : 0    Solos : 0    Units : 0

      The Old Witch of Khador - WJ: +3
      -    Behemoth - PC: 13

      ---

      GENERATED : 11/10/2014 18:03:38
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should not get a warnoun attachment
    And I should get 1 warbj
