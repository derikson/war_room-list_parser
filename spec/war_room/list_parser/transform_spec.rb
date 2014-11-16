require 'spec_helper'

class WarRoom::ListParser
  describe Parser do
    describe '#transform' do
      let(:list) do
        create_list(doctor_heredoc(<<-HERE))
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
        HERE
      end

      let(:theme_list) do
        create_list(doctor_heredoc(<<-HERE))
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
        HERE
      end


      let(:contract_list) do
        create_list(doctor_heredoc(<<-HERE))
          War Room Army

          Mercenaries - Fourstar Syndicate - contract

          0 / 55 (50+5)    Warcaster(s) : 1/1    Warjack(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

          Captain Bartolo Montador - WJ: +5

          ---

          GENERATED : 11/15/2014 23:17:11
        HERE
      end


      describe 'list' do
        it 'has a title' do
          expect(list.title).to eq('everything')
        end

        it 'has a faction' do
          expect(list.faction).to eq('Circle Orboros')
        end

        it 'can have a contract or pact' do
          expect(contract_list.contract_or_pact).to eq('Fourstar Syndicate')
        end

        it 'can be without a contract or pact' do
          expect(list.contract_or_pact).to be_nil
        end

        it 'has a point level' do
          expect(list.point_level).to eq(50)
        end

        it 'has points' do
          expect(list.points).to eq(32)
        end

        it 'has a max points' do
          expect(list.max_points).to eq(53)
        end

        it 'has warbj points' do
          expect(list.warbj_points).to eq(3)
        end

        it 'can have a warnoun' do
          expect(list.warnoun).to_not be_nil
        end

        it 'can have battle engines' do
          expect(list.battle_engines).to_not be_empty
        end

        it 'can have solos' do
          expect(list.solos).to_not be_empty
        end

        it 'can have units' do
          expect(list.units).to_not be_empty
        end

        it 'can have a theme' do
          expect(theme_list.theme).to_not be_nil
        end
      end

      describe 'warnoun' do
        it 'has a name' do
          expect(list.warnoun.to_s).to eq('Kaya the Moonhunter')
        end

        it 'can have an attachment' do
          expect(list.warnoun.attachment).to eq('Druid Wilder')
        end

        it 'can have warbjs' do
          expect(list.warnoun.warbjs.length).to eq(1)
        end
      end

      describe 'warbj' do
        it 'has a name' do
          expect(list.warnoun.warbjs[0].name).to eq('Argus Moonhound')
        end

        it 'has a cost' do
          expect(list.warnoun.warbjs[0].cost).to eq(4)
        end
      end


      describe 'battle engine' do
        it 'has a name' do
          expect(list.battle_engines[0].name).to eq('Sacral Vault')
        end

        it 'has a cost' do
          expect(list.battle_engines[0].cost).to eq(9)
        end
      end


      describe 'solo' do
        it 'has a name' do
          expect(list.solos[0].name).to eq('Blackclad Wayfarer')
        end

        it 'has a cost' do
          expect(list.solos[0].cost).to eq(2)
        end
      end


      describe 'solo attachment' do
        it 'has a name' do
          expect(list.solos[1].attachments[0].name).to eq('Rotterhorn Griffon')
        end

        it 'has a cost' do
          expect(list.solos[1].attachments[0].cost).to eq(3)
        end
      end


      describe 'unit' do
        it 'has a name' do
          expect(list.units[1].name).to eq('Shifting Stones')
        end

        it 'has a descriptor' do
          expect(list.units[1].descriptor).to eq('Leader & 2 Grunts')
        end

        it 'has a cost' do
          expect(list.units[1].cost).to eq(2)
        end
      end


      describe 'unit attachment' do
        it 'has a name' do
          expect(list.units[1].attachments[0].name).to eq('Stone Keeper')
        end

        it 'has a descriptor' do
          expect(list.units[1].attachments[0].descriptor).to eq('Keeper')
        end

        it 'has a cost' do
          expect(list.units[1].attachments[0].cost).to eq(1)
        end
      end

      describe 'theme' do
        it 'has a name' do
          expect(theme_list.theme.name).to eq('Wold War')
        end

        it 'has a tier' do
          expect(theme_list.theme.tier).to eq(4)
        end

        it 'has allowed models' do
          expect(theme_list.theme.allowed_models).to eq("WARBEASTS\r\nCircle non-character construct warbeasts\r\n\r\nUNITS\r\nDruid Stoneward & Woldstalkers, Reeves of Orboros, Sentry Stone & Mannikins, Shifting Stones, Wolves of Orboros, Death Wolves\r\n\r\nSOLOS\r\nBlackclad Wayfarer, Gallows Groves, Reeve Hunters, War Wolves\r\n\r\nBATTLE ENGINES\r\nCelestial Fulcrum")
        end

        it 'has 4 tiers' do
          expect(theme_list.theme.tiers.length).to eq(4)
        end

        describe 'tier' do
          it 'has requirements' do
            expect(theme_list.theme.tiers[2].requirements).to eq('The army includes one or more Sentry Stone & Mannikins units.')
          end

          it 'has benefits' do
            expect(theme_list.theme.tiers[2].benefits).to eq('Sentry Stones begin the game with 3 fury points.')
          end
        end
      end
    end
  end
end
