class WarRoom::ListParser::List::BattleEngine
  attr_reader :name, :cost
  alias_method :to_s, :name

  def initialize(name, cost)
    @name, @cost = name, cost
  end
end
