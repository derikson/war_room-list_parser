require 'spec_helper'

module WarRoom
  describe ListParser do
    describe '#parse' do
      def doctor_heredoc string
        string.gsub(/(?<!\r)\n/, "\r\n").gsub(/^\ */, '')
      end

      it 'throws an WarRoom::ListParser::InvalidListException when given an invalid list' do
        begin
          WarRoom::ListParser.new.parse('')
        rescue WarRoom::ListParser::InvalidListException => e
          true
        else
          false
        end
      end

      it 'parses a list' do
        WarRoom::ListParser.new.parse(doctor_heredoc(<<-HERE))
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
        WarRoom::ListParser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Legion of Everblight - no battlegroup

          5 / 15 (15+0)    Warlock(s) : 0/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 1

          Blackfrost Shard - Sevryn, Rhylyss, and Vysarr: 5

          ---

          GENERATED : 11/10/2014 19:51:11
        HERE
      end


      it 'parses a solo with a hyphen in the name' do
        WarRoom::ListParser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Khador - solo with option

          4 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 1    Units : 0

          Man-O-War Drakhun - PC: 4

          ---

          GENERATED : 11/10/2014 20:07:42
        HERE
      end


      it 'parses a list with only a warlock' do
        WarRoom::ListParser.new.parse(doctor_heredoc(<<-HERE))
          War Room Army

          Trollblood - New Army

          0 / 21 (15+6)    Warlock(s) : 1/1    Warbeast(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

          Borka, Vengeance of the Rimeshaws - WB: +6

          ---

          GENERATED : 11/10/2014 02:07:03
        HERE
      end
    end
  end
end
