require 'spec_helper'

class WarRoom::ListParser
  describe Parser do
    describe '#parse' do
      it 'throws an exception on an empty list' do
        expect { Parser.new.parse(doctor_heredoc(<<-HERE)) }.to raise_error(Parslet::ParseFailed)
          War Room Army

          Khador - empty list

          0 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

          ---

          GENERATED : 11/09/2014 10:46:12
        HERE
      end

      it 'parses a list' do
        Parser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Trollblood - New Army

          0 / 20 (15+5)    Warlock(s) : 1/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

          Borka Kegslayer - WB: +5
          -    Pyg Keg Carrier

          ---

          GENERATED : 11/10/2014 02:09:03
        HERE
      end

      it 'parses a list without a battlegroup' do
        Parser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Legion of Everblight - no battlegroup

          5 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 1

          Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

          ---

          GENERATED : 11/10/2014 19:51:11
        HERE
      end


      it 'has nil warbjs if there is no battlegroup' do
        expect(Parser.new.parse(doctor_heredoc(<<-HERE))[:warbjs]).to be_nil
          War Room Army

          Legion of Everblight - no battlegroup

          5 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 1

          Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

          ---

          GENERATED : 11/10/2014 19:51:11
        HERE
      end


      it 'parses a solo with a hyphen in the name' do
        Parser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Khador - solo with option

          4 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

          Man-O-War Drakhun - PC: 4

          ---

          GENERATED : 11/10/2014 20:07:42
        HERE
      end


      it 'parses a list with only a warlock' do
        Parser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Trollblood - New Army

          0 / 21 (15+6)    Warlock(s) : 1/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

          Borka, Vengeance of the Rimeshaws - WB: +6

          ---

          GENERATED : 11/10/2014 02:07:03
        HERE
      end

      describe 'totals' do
        let(:hordes_list) do
          doctor_heredoc(<<-HERE)
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

        it 'parses Warlock totals' do
          parser = Parser.new.parse(hordes_list)
          expect(parser[:totals][:warnouns][:total]).to eq('1')
        end

        it 'parses battle engine totals' do
          parser = Parser.new.parse(hordes_list)
          expect(parser[:totals][:battle_engines][:total]).to eq('1')
        end

        it 'parses solo totals' do
          parser = Parser.new.parse(hordes_list)
          expect(parser[:totals][:solos][:total]).to eq('3')
        end

        it 'parses unit totals' do
          parser = Parser.new.parse(hordes_list)
          expect(parser[:totals][:units][:total]).to eq('2')
        end
      end
    end
  end
end

