class WarRoom::ListParser::List::SoloAttachment
  attr_reader :name, :cost
  alias_method :to_s, :name

  def initialize(name, cost)
    @name = name
    @cost = cost
  end
end
