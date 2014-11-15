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

      describe 'list' do
        it 'has a title' do
          expect(list.title).to eq('everything')
        end

        it 'has a faction' do
          expect(list.faction).to eq('Circle Orboros')
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
    end
  end
end
