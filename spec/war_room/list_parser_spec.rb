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
    end
  end
end
