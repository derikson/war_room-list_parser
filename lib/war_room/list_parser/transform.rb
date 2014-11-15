class WarRoom::ListParser::Transform < Parslet::Transform
  rule(total: simple(:n)) { Integer n }

  rule(warnoun_attachment_name: simple(:name)) { name }

  rule(warnoun:    {name: simple(:name), points: simple(:points)},
       attachment: simple(:attachment),
       warbjs:     sequence(:warbjs)) do
    WarRoom::ListParser::List::Warnoun.new(name, points: Integer(points), attachment: attachment, warbjs: warbjs)
  end


  rule(warnoun:    {name: simple(:name), points: simple(:points)},
       attachment: simple(:attachment),
       warbjs:     simple(:warbjs)) do
    WarRoom::ListParser::List::Warnoun.new(name, points: Integer(points), attachment: attachment)
  end


  rule(warbj_name: simple(:name),
       cost:       simple(:cost)) do
    WarRoom::ListParser::List::Warbj.new(name, Integer(cost))
  end


  rule(battle_engine_name: simple(:name),
       cost:               simple(:cost)) do
    WarRoom::ListParser::List::BattleEngine.new(name, Integer(cost))
  end


  rule(name:             simple(:name),
       cost:             simple(:cost),
       solo_attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Solo.new(name, cost: Integer(cost), attachments: attachments)
  end


  rule(solo_attachment_name: simple(:name),
       cost:                 simple(:cost)) do
    WarRoom::ListParser::List::SoloAttachment.new(name, Integer(cost))
  end


  rule(name:             simple(:name),
       cost:             simple(:cost),
       descriptor:       simple(:descriptor),
       unit_attachments: sequence(:attachments)) do
    WarRoom::ListParser::List::Unit.new(name, cost: Integer(cost), descriptor: descriptor, attachments: attachments)
  end


  rule(unit_attachment_name: simple(:name),
       cost:                 simple(:cost),
       descriptor:           simple(:descriptor)) do
    WarRoom::ListParser::List::UnitAttachment.new(name, cost: Integer(cost), descriptor: descriptor)
  end


  rule(unit_attachment_name: simple(:name),
       cost:                 simple(:cost)) do
    WarRoom::ListParser::List::UnitAttachment.new(name, cost: Integer(cost))
  end


  rule(faction:        simple(:faction),
       title:          simple(:title),
       totals:         subtree(:totals),
       warnoun:        simple(:warnoun),
       battle_engines: sequence(:battle_engines),
       solos:          sequence(:solos),
       units:          sequence(:units),
       theme:          subtree(:theme)) do
    WarRoom::ListParser::List.new(title: title, faction: faction, warnoun: warnoun, battle_engines: battle_engines, solos: solos, units: units)
  end
end
