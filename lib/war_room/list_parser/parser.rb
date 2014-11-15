# coding: utf-8
class WarRoom::ListParser::Parser < Parslet::Parser
  def self.section_repeat(rule_name, section_item)
    rule(rule_name) { (send(section_item) >> newline).repeat >> newline }
  end

  rule(:total) { space >> str(':') >> space >> number.as(:total) }

  rule(:number) { match('\d').repeat(1, nil) }

  rule(:space)         { str(' ').repeat(1, nil) }
  rule(:before_hyphen) { (hyphen.absent? >> match['^\r\n'] ).repeat(1, nil) }
  rule(:hyphen)        { space >> str('-') >> space }
  rule(:newline)       { str("\r\n") }
  rule(:empty_line)    { newline.repeat(2) }

  rule(:pc) { str('PC: ') >> number.as(:cost) }
  rule(:descriptor_and_cost) {
    ((str(':').maybe >> space >> number >> newline).absent? >> any).repeat(1, nil).as(:descriptor) >>
      str(':').maybe >> space >> number.as(:cost)
  }

  rule(:warroom_header) { str('War Room Army') >> empty_line }

  rule(:faction) { before_hyphen }
  rule(:title) { match['^\n\r'].repeat(1, nil) }

  rule(:totals) {
    number.as(:points) >> str(' / ') >> number.as(:max_points) >> space >>
      str('(') >> number.as(:point_level) >> str('+') >> number.as(:warbj_points) >> str(')') >> space >>
      (str('Warcaster(s)')   | str('Warlock(s)' )) >> total.as(:warnouns)       >> str('/') >> number >> space >>
      (str('Warjack(s)')     | str('Warbeast(s)')) >> total.as(:warbjs)         >> space >>
       str('Battle Engines')                       >> total.as(:battle_engines) >> space >>
       str('Solos')                                >> total.as(:solos)          >> space >>
       str('Units')                                >> total.as(:units)          >>
      empty_line
  }

  rule(:battlegroup_and_attachment) {
    warnoun.as(:warnoun) >>
      warnoun_attachment.maybe.capture(:warnoun_attachment).as(:attachment) >>
      warbjs.repeat(0,1).as(:warbjs) >> newline
  }


  rule(:warnoun)             { before_hyphen.as(:name) >> hyphen >> (str('WB: +') | str('WJ: +')) >> match('\d').repeat(1, nil).as(:points) >> newline }
  rule(:warnoun_attachment)  { str('-') >> space >> (match['^\r\n'] >> str('PC:').absent?).repeat(1, nil).as(:warnoun_attachment_name) >> newline }
  rule(:warbj)               { str('-') >> space >> before_hyphen.as(:warbj_name) >> hyphen >> pc }
  rule(:warbjs)              { (warbj >> newline).repeat }

  rule(:battle_engine) { before_hyphen.as(:battle_engine_name) >> hyphen >> pc }
  section_repeat(:battle_engines, :battle_engine)

  rule(:solo)            { str('-').absent? >> before_hyphen.as(:name) >> hyphen >> pc >> (newline >> solo_attachment).repeat.as(:solo_attachments) }
  rule(:solo_attachment) { str('-') >> space >> before_hyphen.as(:solo_attachment_name) >> hyphen >> pc }
  section_repeat(:solos, :solo)

  rule(:unit)            { str('-').absent? >> before_hyphen.as(:name) >> hyphen >> (pc | descriptor_and_cost) >> (newline >> unit_attachment).repeat.as(:unit_attachments) }
  rule(:unit_attachment) { str('-') >> space >> before_hyphen.as(:unit_attachment_name) >> hyphen >> (pc | descriptor_and_cost) }
  section_repeat(:units, :unit)

  rule(:rest) { any.repeat }

  # theme
  rule(:theme_header)   { str('THEME: ') >> before_hyphen.as(:name) >> hyphen >> str('Tier ') >> number.as(:tier) }
  rule(:allowed_models) { ((empty_line >> str('TIER 1')).absent? >> any).repeat.as(:allowed_models) >> empty_line }
  rule(:tier) {
    str('TIER ') >> number.as(:tier) >> (hyphen >> str('SELECTED').as(:selected)).maybe >> newline >>
      str('---Requirements---') >> newline >>
      ((newline >> str('---Benefits---')).absent? >> any).repeat(1, nil).as(:requirements) >> newline >>
      str('---Benefits---') >> newline >>
      (empty_line.absent? >> any).repeat(1, nil).as(:benefits)
  }
  rule(:tiers) { (tier >> empty_line).repeat(1, nil) }
  rule(:theme) { theme_header >> allowed_models >> tiers.as(:tiers) }

  # str('⊥').repeat.as is used just so that we get an empty array if there aren't any of the list item type
  rule(:warroom_list) {
    warroom_header >>
      faction.as(:faction) >> hyphen >> title.as(:title) >> empty_line >>
      totals.capture(:totals).as(:totals) >>
      dynamic { |s, c| c.captures[:totals][:warnouns][:total]       != '0' ? battlegroup_and_attachment.as(:warnoun) : str('⊥').maybe.as(:warnoun) } >>
      dynamic { |s, c| c.captures[:totals][:battle_engines][:total] != '0' ? battle_engines.as(:battle_engines)      : str('⊥').repeat.as(:battle_engines) } >>
      dynamic do |source, context|
        warnoun_attachment = (context.captures[:totals][:warnouns][:total] != '0') && (context.captures[:warnoun_attachment] != '')
        solos_total = context.captures[:totals][:solos][:total].to_i - (warnoun_attachment ? 1 : 0)
        # War Room bug treats warnoun attachments as solos only sometimes
        solos_total != 0 ? solos.repeat(0,1).as(:solos) : str('⊥').repeat.as(:solos)
      end >>
      dynamic { |s, c| c.captures[:totals][:units][:total] != '0' ? units.as(:units) : str('⊥').repeat.as(:units) } >>
      theme.maybe.as(:theme) >>
      str('--') >>
      rest }

  root(:warroom_list)
end
