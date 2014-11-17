class WarRoom::ListParser::Transform < Parslet::Transform
  rule(total: simple(:n)) { Integer n }

  rule(warnoun_attachment_name: simple(:name)) do
    WarRoom::ListParser::List::Item.new(name)
  end

  rule(warnoun:    {name: simple(:name), points: simple(:points)},
       attachment: simple(:attachment),
       warbjs:     sequence(:warbjs)) do
    WarRoom::ListParser::List::Item.new(name, warbj_points: Integer(points), attachments: (attachment ? [attachment] : []) + warbjs)
  end


  rule(warnoun:    {name: simple(:name), points: simple(:points)},
       attachment: simple(:attachment),
       warbjs:     simple(:warbjs)) do
    WarRoom::ListParser::List::Item.new(name, warbj_points: Integer(points), attachments: attachment ? [attachment] : [])
  end


  rule(warbj_name: simple(:name),
       cost:       simple(:cost)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost))
  end


  rule(battle_engine_name: simple(:name),
       cost:               simple(:cost)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost))
  end


  rule(name:             simple(:name),
       cost:             simple(:cost),
       solo_attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost), attachments: attachments)
  end


  rule(solo_attachment_name: simple(:name),
       cost:                 simple(:cost)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost))
  end


  rule(name:             simple(:name),
       cost:             simple(:cost),
       descriptor:       simple(:descriptor),
       unit_attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost), descriptor: descriptor, attachments: attachments)
  end


  rule(unit_attachment_name: simple(:name),
       cost:                 simple(:cost),
       descriptor:           simple(:descriptor)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost), descriptor: descriptor)
  end


  rule(unit_attachment_name: simple(:name),
       cost:                 simple(:cost)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost))
  end


  rule(name:           simple(:name),
       tier:           simple(:tier),
       allowed_models: simple(:allowed_models),
       tiers:          sequence(:tiers)) do
    WarRoom::ListParser::List::Theme.new(name, tier: Integer(tier), allowed_models: allowed_models, tiers: tiers)
  end


  rule(tier:         simple(:tier),
       requirements: simple(:requirements),
       benefits:     simple(:benefits)) do
    WarRoom::ListParser::List::Theme::Tier.new(requirements, benefits)
  end

  rule(faction:          simple(:faction),
       contract_or_pact: simple(:contract_or_pact),
       title:            simple(:title),
       totals:           {points:         simple(:points),
                          max_points:     simple(:max_points),
                          point_level:    simple(:point_level),
                          warbj_points:   simple(:warbj_points),
                          warnouns:       simple(:total_warnouns),
                          warbjs:         simple(:total_warbjs),
                          battle_engines: simple(:total_battle_engines),
                          solos:          simple(:total_solos),
                          units:          simple(:total_units)},
       warnoun:          simple(:warnoun),
       battle_engines:   sequence(:battle_engines),
       solos:            sequence(:solos),
       units:            sequence(:units),
       theme:            simple(:theme)) do
    WarRoom::ListParser::List.new(title:            title,
                                  faction:          faction,
                                  contract_or_pact: contract_or_pact,
                                  point_level:      Integer(point_level),
                                  points:           Integer(points),
                                  max_points:       Integer(max_points),
                                  warbj_points:     Integer(warbj_points),
                                  warnoun:          warnoun,
                                  battle_engines:   battle_engines,
                                  solos:            solos,
                                  units:            units,
                                  theme:            theme)
  end
end
