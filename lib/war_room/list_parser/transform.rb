class WarRoom::ListParser::Transform < Parslet::Transform
  rule(total: simple(:n)) { Integer n }

  rule(name: simple(:name)) do
    WarRoom::ListParser::List::Item.new(name)
  end

  rule(name:        simple(:name),
       points:      simple(:points),
       attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Item.new(name, warbj_points: Integer(points), attachments: attachments)
  end

  rule(name: simple(:name),
       cost: simple(:cost)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost))
  end


  rule(name:        simple(:name),
       cost:        simple(:cost),
       attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost), attachments: attachments)
  end

  rule(name:        simple(:name),
       descriptor:  simple(:descriptor),
       cost:        simple(:cost)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost), descriptor: descriptor)
  end

  rule(name:        simple(:name),
       descriptor:  simple(:descriptor),
       cost:        simple(:cost),
       attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Item.new(name, cost: Integer(cost), descriptor: descriptor, attachments: attachments)
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


  rule(items: sequence(:items)) { items }


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
       sections:         subtree(:sections),
       theme:            simple(:theme)) do
    warnoun        = total_warnouns > 0 ? sections.shift[0] : nil
    battle_engines = total_battle_engines > 0 ? sections.shift : []
    units          = total_units > 0 ? sections.pop : []
    # can't rely on total_solos, because sometimes a warlock attachment acts as a solo, sometimes it doesn't
    solos          = sections.length > 0 ? sections.shift : []
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
