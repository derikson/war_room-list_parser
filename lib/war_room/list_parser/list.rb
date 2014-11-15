class WarRoom::ListParser::List
  attr_reader :title, :faction, :point_level, :points, :max_points, :warbj_points, :warnoun, :battle_engines, :solos, :units, :theme

  def initialize(title:, faction:, points:, point_level:, max_points:, warbj_points: 0, warnoun: [], battle_engines: [], solos: [], units: [], theme: nil)
    @title          = title
    @faction        = faction
    @point_level    = point_level
    @points         = points
    @max_points     = max_points
    @warbj_points   = warbj_points
    @warnoun        = warnoun
    @battle_engines = battle_engines
    @solos          = solos
    @units          = units
    @theme          = theme
    raise WarRoom::ListParser::InvalidListException unless warnoun || !battle_engines.empty? || !solos.empty? || !units.empty?
  end
end
