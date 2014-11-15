class WarRoom::ListParser::List::Solo
  attr_reader :name, :cost, :attachments
  alias_method :to_s, :name

  def initialize(name, cost: 0, attachments: nil)
    @name        = name
    @cost        = cost
    @attachments = attachments
  end
end
