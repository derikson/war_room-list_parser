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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 1 unit
    And I should get 0 unit attachments


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
    And I should get 1 warnoun
    And I should get a combined total of 1 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 1 unit
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 1 battle engine
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 0 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 2 battle engines
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 0 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 1 solo
    And I should get 0 solo attachments
    And I should get 0 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 2 solos
    And I should get 0 solo attachments
    And I should get 0 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 1 solo
    And I should get 0 solo attachments
    And I should get 0 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 1 solo
    And I should get 1 solo attachment
    And I should get 0 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 2 units
    And I should get 0 unit attachments


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
    And I should get 0 warnouns
    And I should get a combined total of 0 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 2 units
    And I should get 1 unit attachment


  Scenario: 'jack marshal solo in warmachine list
    Given a list of:
      """
      War Room Army

      Cygnar - jack marshal solo

      12 / 53 (50+3)    Warcaster(s) : 1/1    Warjack(s) : 1    Battle Engines : 0    Solos : 2    Units : 0

      Artificer General Nemo - WJ: +3
      -    Storm Chaser Adept Caitlin Finch

      Archduke Alain Runewood, Lord of Fharin - PC: 3
      -    Avenger - PC: 9

      ---

      GENERATED : 11/14/2014 00:22:19
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should get a combined total of 1 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 1 solos
    And I should get 1 solo attachments
    And I should get 0 units
    And I should get 0 unit attachment


  Scenario: 'jack marshal unit
    Given a list of:
      """
      War Room Army

      Cygnar - jack marshal unit

      7 / 53 (50+3)    Warcaster(s) : 1/1    Warjack(s) : 1    Battle Engines : 0    Solos : 1    Units : 1

      Artificer General Nemo - WJ: +3
      -    Storm Chaser Adept Caitlin Finch

      Field Mechaniks - Crew Chief & 5 Grunts: 3
      -    Charger - PC: 4

      ---

      GENERATED : 11/14/2014 00:21:23
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnoun
    And I should get a combined total of 1 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 0 solos
    And I should get 0 solo attachments
    And I should get 1 units
    And I should get 1 unit attachment


  Scenario: hordes list with a 'jack marshal solo
    Given a list of:
      """
      War Room Army

      Trollblood - hordes jack marshal

      11 / 55 (50+5)    Warlock(s) : 1/1    Warbeast(s) : 2    Battle Engines : 0    Solos : 2    Units : 0

      Borka Kegslayer - WB: +5
      -    Pyg Keg Carrier

      Raluk Moorclaw, the Ironmonger - PC: 2
      -    Buccaneer - PC: 3
      -    Freebooter - PC: 6

      ---

      GENERATED : 11/14/2014 00:39:54
      """
    When I parse the list
    Then I should get a parsed list
    And I should get 1 warnouns
    And I should get a combined total of 1 warnoun attachments and warnoun warbjs
    And I should get 0 battle engines
    And I should get 1 solos
    And I should get 2 solo attachments
    And I should get 0 units
    And I should get 0 unit attachment


  Scenario: mercanary list with a contract
    Given a list of:
      """
      War Room Army

      Mercenaries - Fourstar Syndicate - contract

      0 / 55 (50+5)    Warcaster(s) : 1/1    Warjack(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

      Captain Bartolo Montador - WJ: +5

      ---

      GENERATED : 11/15/2014 23:17:11
      """
    When I parse the list
    Then I should get a parsed list
    And I should get a faction of "Mercenaries"
    And I should get a contract called "Fourstar Syndicate"
    And I should get a list title of "contract"


  Scenario: minion list with a pact
    Given a list of:
      """
      War Room Army

      Minions - Blindwater Congregation - pact

      0 / 56 (50+6)    Warlock(s) : 1/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

      Bloody Barnabas - WB: +6

      ---

      GENERATED : 11/15/2014 23:15:54
      """
    When I parse the list
    Then I should get a parsed list
    And I should get a faction of "Minions"
    And I should get a pact called "Blindwater Congregation"
    And I should get a list title of "pact"


  Scenario: a list with a little of everything
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
    And I should get a list title of "everything"
    And I should get a list with a point level of 50
    And I should get a list with 32 points
    And I should get a list with a max points of 53
    And I should get a list 3 warbj points
    And I should get a faction of "Circle Orboros"
    And I should get 1 warnoun
    And I should get a warnoun with a name of "Kaya the Moonhunter" and 3 points
    And I should get a combined total of 2 warnoun attachments and warnoun warbjs
    And I should get a warnoun attachment or warnoun warbj with a name of "Druid Wilder"
    And I should get a warnoun attachment or warnoun warbj with a name of "Argus Moonhound" and a cost of 4
    And I should get 1 battle engine
    And i should get a battle engine with a name of "Sacral Vault" and a cost of 9
    And I should get 3 solos
    And I should get a solo with a name of "Una the Falconer" and a cost of 3
    And I should get 1 solo attachment
    And I should get a solo attachment with a name of "Rotterhorn Griffon" and a cost of 3
    And I should get 2 units
    And I should get a unit with a name of "Shifting Stones", an descriptor of "Leader & 2 Grunts", and a cost of 2
    And I should get 1 unit attachment
    And I should get a unit attachment with a name of "Stone Keeper", a descriptor of "Keeper", and a cost of 1
    And I should not get a theme
