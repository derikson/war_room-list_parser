# coding: utf-8
class WarRoom::ListParser::Parser < Parslet::Parser
  # match as nil. use #as to insert an array into the tree
  rule(:empty_match_nil)      { str('⊥').maybe  }

  rule(:total) { space >> str(':') >> space >> number.as(:total) }

  rule(:number) { match('\d').repeat(1, nil) }

  rule(:space)      { str(' ').repeat(1, nil) }
  rule(:not_hyphen) { (hyphen.absent? >> match['^\r\n'] ).repeat(1, nil) }
  rule(:hyphen)     { space >> str('-') >> space }
  rule(:newline)    { str("\r\n") }
  rule(:empty_line) { newline.repeat(2) }

  rule(:pc) { str('PC: ') >> number.as(:cost) }
  rule(:descriptor_and_cost) do
    ((str(':').maybe >> space >> number >> newline).absent? >> any).repeat(1, nil).as(:descriptor) >>
      str(':').maybe >> space >> number.as(:cost)
  end


  rule(:warroom_header) { str('War Room Army') >> empty_line }

  rule(:faction) { not_hyphen }
  rule(:title) { match['^\n\r'].repeat(1, nil) }

  rule(:header) do
    ((str("Mercenaries") | str("Minions")).as(:faction) >> hyphen >> not_hyphen.as(:contract_or_pact) |
     faction.as(:faction) >> empty_match_nil.as(:contract_or_pact)) >>
      hyphen >> title.as(:title) >> empty_line
  end

  rule(:totals) do
    number.as(:points) >> str(' / ') >> number.as(:max_points) >> space >>
      str('(') >> number.as(:point_level) >> str('+') >> number.as(:warbj_points) >> str(')') >> space >>
      (str('Warcaster(s)')   | str('Warlock(s)' )) >> total.as(:warnouns)       >> str('/') >> number >> space >>
      (str('Warjack(s)')     | str('Warbeast(s)')) >> total.as(:warbjs)         >> space >>
       str('Battle Engines')                       >> total.as(:battle_engines) >> space >>
       str('Solos')                                >> total.as(:solos)          >> space >>
       str('Units')                                >> total.as(:units)          >>
      empty_line
  end


  rule(:attachment) do
    str('- ') >> space >>
    (pc.absent? >> hyphen.absent? >> match['^\r\n']).repeat(1, nil).as(:name) >>
      (hyphen >> (pc | descriptor_and_cost)).maybe >>
      newline
  end

  rule(:top_level_list_item) do
    ((str('THEME').absent? >> pc.absent? >> hyphen.absent? >> match['^\r\n']).repeat(1, nil).as(:name) >>
      (hyphen >> ((str('WB: +') | str('WJ: +')) >> match('\d').as(:points) | pc | descriptor_and_cost)) >>
      newline >> attachment.repeat.as(:attachments))
  end

  rule(:section) { top_level_list_item.repeat(1,nil).as(:items) >> newline }

  rule(:rest) { any.repeat }

  # theme
  rule(:theme_header)   { str('THEME: ') >> not_hyphen.as(:name) >> hyphen >> str('Tier ') >> number.as(:tier) }
  rule(:allowed_models) { ((empty_line >> str('TIER 1')).absent? >> any).repeat.as(:allowed_models) >> empty_line }
  rule(:tier) do
    str('TIER ') >> number.as(:tier) >> (hyphen >> str('SELECTED')).maybe >> newline >>
      str('---Requirements---') >> newline >>
      ((newline >> str('---Benefits---')).absent? >> any).repeat(1, nil).as(:requirements) >> newline >>
      str('---Benefits---') >> newline >>
      (empty_line.absent? >> any).repeat(1, nil).as(:benefits)
  end
  rule(:tiers) { (tier >> empty_line).repeat(1, nil) }
  rule(:theme) { theme_header >> empty_line >> allowed_models >> tiers.as(:tiers) }

  rule(:warroom_list) do
    warroom_header >>
      header >>
      totals.capture(:totals).as(:totals) >>
      section.repeat(1,4).as(:sections) >>
      theme.maybe.as(:theme) >>
      str('--') >>
      rest
  end

  root(:warroom_list)
end
