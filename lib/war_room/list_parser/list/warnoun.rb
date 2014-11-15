class WarRoom::ListParser::List::Warnoun
  attr_reader :name, :points, :attachment
  alias_method :to_s, :name

  def initialize(name, points:, attachment: nil, warbjs: [])
    @name       = name
    @points     = points
    @attachment = attachment
    @warbjs     = warbjs
  end

  def warbjs; @warbjs ||= [] end
end
