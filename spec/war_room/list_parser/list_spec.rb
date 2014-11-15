require 'spec_helper'

class WarRoom::ListParser
  describe List do
    let(:empty_list_text) do
      doctor_heredoc(<<-HERE)
        War Room Army

        Khador - empty list

        0 / 50 (50+0)    Warcaster(s) : 0/1    Warjack(s) : 0    Battle Engines : 0    Solos : 0    Units : 0

        ---

        GENERATED : 11/09/2014 10:46:12
      HERE
    end
    it 'throws an exception on an empty list' do
      expect { create_list(empty_list_text) }.to raise_error(InvalidListException)
    end
  end
end
