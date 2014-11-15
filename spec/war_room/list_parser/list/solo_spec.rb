require 'spec_helper'

class WarRoom::ListParser::List
  describe Solo do
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

    it 'has a name' do
      expect(list.solos[0].to_s).to eq('Blackclad Wayfarer')
    end

    it 'has a cost' do
      expect(list.solos[0].cost).to eq(2)
    end

    it 'can have attachments' do
      expect(list.solos[1].attachments.length).to eq(1)
    end
  end
end
