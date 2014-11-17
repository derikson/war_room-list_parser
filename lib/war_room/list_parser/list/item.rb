class WarRoom::ListParser::List::Item
  attr_reader :name, :cost, :warbj_points, :descriptor, :attachments
  alias_method :to_s, :name

  def initialize(name, cost: nil, warbj_points: nil, descriptor: nil, attachments: [])
    @name         = name
    @cost         = cost
    @warbj_points = warbj_points
    @descriptor   = descriptor
    @attachments  = attachments
  end
end
