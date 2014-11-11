Feature: developer submits a battlegroup-only, Hordes War Room list

  As a developer
  I want to parse War Room lists
  So that I can use the data in my other programs


  Scenario: no battle group
    Given a list of:
      """
      War Room Army

      Legion of Everblight - no battlegroup

      5 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 1

      Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

      ---

      GENERATED : 11/10/2014 19:51:11
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: battlegroup and unit
    Given a list of:
      """
      War Room Army

      Legion of Everblight - battlegroup and unit

      16 / 20 (15+5)    Warlock(s) : 1/1    Warbeast(s) : 1    Battle Engines : 0    Solos : 0    Units : 1

      Absylonia, Daughter of Everblight - WB: +5
      -    Carnivean - PC: 11

      Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

      ---

      GENERATED : 11/10/2014 19:53:33
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: a battle engine
    Given a list of:
      """
      War Room Army

      Legion of Everblight - battle engine

      9 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 1    Solos : 0    Units : 0

      Throne of Everblight - PC: 9

      ---

      GENERATED : 11/10/2014 20:01:40
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: 2 battle engines
    Given a list of:
      """
      War Room Army

      Legion of Everblight - battle engines

      18 / 50 (50+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 2    Solos : 0    Units : 0

      Throne of Everblight - PC: 9
      Sacral Vault - PC: 9

      ---

      GENERATED : 11/10/2014 20:02:24
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: a solo
    Given a list of:
      """
      War Room Army

      Khador - solo

      3 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

      Ogrun Bokur - PC: 3

      ---

      GENERATED : 11/10/2014 20:06:19
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: 2 solos
    Given a list of:
      """
      War Room Army

      Khador - solos

      6 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 2    Units : 0

      Ogrun Bokur - PC: 3
      Man-O-War Kovnik - PC: 3

      ---

      GENERATED : 11/10/2014 20:07:06
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: solo with option
    Given a list of:
      """
      War Room Army

      Khador - solo with option

      4 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

      Man-O-War Drakhun - PC: 4

      ---

      GENERATED : 11/10/2014 20:07:42
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: lesser warlock solo
    Given a list of:
      """
      War Room Army

      Circle Orboros - lesser warlock

      6 / 50 (50+0)    Warlock(s) : 0/1    Warbeast(s) : 1    Battle Engines : 0    Solos : 1    Units : 0

      Una the Falconer - PC: 3
      -    Rotterhorn Griffon - PC: 3

      ---

      GENERATED : 11/10/2014 20:12:11
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: 2 units
    Given a list of:
      """
      War Room Army

      Legion of Everblight - 2 units

      13 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 2

      Blighted Nyss Archers - Leader & 9 Grunts: 8
      Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

      ---

      GENERATED : 11/10/2014 19:56:38
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: a unit attachment
    Given a list of:
      """
      War Room Army

      Legion of Everblight - ua

      15 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 2

      Blighted Nyss Archers - Leader & 9 Grunts: 8
      -    Blighted Nyss Archer Officer & Ammo Porter - Blighted Nyss Archer Officer & Ammo Porter 2
      Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

      ---

      GENERATED : 11/10/2014 19:59:46
      """
    When I parse the list
    Then I should get a parsed list


  Scenario: a little of everything
    Given a list of:
      """
      War Room Army

      Circle Orboros - everything

      32 / 53 (50+3)    Warlock(s) : 1/1    Warbeast(s) : 3    Battle Engines : 1    Solos : 3    Units : 2

      Kaya the Moonhunter - WB: +3
      -    Druid Wilder
      -    Argus Moonhound - PC: 4

      Sacral Vault - PC: 9

      Blackclad Wayfarer - PC: 2
      Una the Falconer - PC: 3
      -    Rotterhorn Griffon - PC: 3
      Una the Falconer <! OVER FIELD ALLOWANCE !> - PC: 3

      Sentry Stone & Mannikins - Leader & 3 Grunts: 3
      Shifting Stones - Leader & 2 Grunts: 2
      -    Stone Keeper - Keeper 1

      ---

      GENERATED : 11/10/2014 20:19:18
      """
    When I parse the list
    Then I should get a parsed list
