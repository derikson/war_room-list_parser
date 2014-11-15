class WarRoom::ListParser::List
  attr_reader :title, :faction, :warnoun, :battle_engines, :solos, :units

  def initialize(title:, faction:, warnoun: [], battle_engines: [], solos: [], units: [])
    @title, @faction, @warnoun, @battle_engines, @solos, @units = title, faction, warnoun, battle_engines, solos, units
    raise WarRoom::ListParser::InvalidListException unless warnoun || !battle_engines.empty? || !solos.empty? || !units.empty?
  end
end
