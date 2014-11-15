class WarRoom::ListParser::List::Unit
  attr_reader :name, :cost, :descriptor, :attachments
  alias_method :to_s, :name

  def initialize(name, cost: 0, descriptor: nil, attachments: nil)
    @name        = name
    @cost        = cost
    @descriptor  = descriptor
    @attachments = attachments
  end
end
