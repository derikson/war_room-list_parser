class WarRoom::ListParser::List::UnitAttachment
  attr_reader :name, :cost, :descriptor
  alias_method :to_s, :name

  def initialize(name, cost: 0, descriptor: nil)
    @name        = name
    @cost        = cost
    @descriptor  = descriptor
  end
end
