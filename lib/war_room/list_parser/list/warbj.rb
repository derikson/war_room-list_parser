class WarRoom::ListParser::List::Warbj
  attr_reader :name, :cost
  alias_method :to_s, :name

  def initialize(name, cost)
    @name, @cost = name, cost
  end
end
