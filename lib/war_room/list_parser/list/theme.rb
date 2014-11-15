class WarRoom::ListParser::List::Theme
  attr_reader :name, :tier, :allowed_models, :tiers

  def initialize(name, tier:, allowed_models:, tiers:)
    @name           = name
    @tier           = tier
    @allowed_models = allowed_models
    @tiers          = tiers
  end
end
