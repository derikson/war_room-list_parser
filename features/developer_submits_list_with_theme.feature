Feature: developer submits a battlegroup-only, Hordes War Room list

  As a developer
  I want to parse War Room lists with themes
  So that I can use the data in my other programs


  Scenario: theme list
    Given a list of:
      """
      War Room Army

      Circle Orboros - bb bradigus

      56 / 56 (50+6)    Warlock(s) : 1/1    Warbeast(s) : 7    Battle Engines : 0    Solos : 0    Units : 4

      Bradigus Thorle the Runecarver - WB: +6
      -    Wold Guardian - PC: 9
      -    Woldwatcher - PC: 0
      -    Woldwatcher - PC: 5
      -    Woldwatcher - PC: 5
      -    Woldwarden - PC: 9
      -    Woldwarden - PC: 9
      -    Wold Guardian - PC: 9

      Sentry Stone & Mannikins - Leader & 3 Grunts: 3
      Shifting Stones - Leader & 2 Grunts: 2
      Shifting Stones - Leader & 2 Grunts: 2
      Sentry Stone & Mannikins - Leader & 3 Grunts: 3

      THEME: Wold War - Tier 4

      WARBEASTS
      Circle non-character construct warbeasts

      UNITS
      Druid Stoneward & Woldstalkers, Reeves of Orboros, Sentry Stone & Mannikins, Shifting Stones, Wolves of Orboros, Death Wolves

      SOLOS
      Blackclad Wayfarer, Gallows Groves, Reeve Hunters, War Wolves

      BATTLE ENGINES
      Celestial Fulcrum

      TIER 1
      ---Requirements---
      The army can only include the models listed above.
      ---Benefits---
      Increase the FA of Shifting Stone units and Sentry Stone & Mannikins units by 1.

      TIER 2
      ---Requirements---
      The army includes one or more Shifting Stone units.
      ---Benefits---
      You can redeploy one model/unit after both players have deployed but before the first player's first turn. The redeployed models must be placed on the table in a location they could have been deployed initially.

      TIER 3
      ---Requirements---
      The army includes one or more Sentry Stone & Mannikins units.
      ---Benefits---
      Sentry Stones begin the game with 3 fury points.

      TIER 4 - SELECTED
      ---Requirements---
      The only living model in the army is Bradigus Thorle the Runecarver.
      ---Benefits---
      Add a Woldwatcher to Thorle's battlegroup free of cost.

      ---

      GENERATED : 10/29/2014 10:22:20
      """
    When I parse the list
    Then I should get a parsed list
