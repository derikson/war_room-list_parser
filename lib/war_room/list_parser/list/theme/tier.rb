class WarRoom::ListParser::List::Theme::Tier
  attr_reader :requirements, :benefits

  def initialize(requirements, benefits)
    @requirements, @benefits = requirements, benefits
  end
end
