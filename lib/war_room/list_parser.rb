require 'war_room/list_parser/version'
require 'war_room/list_parser/invalid_list_exception'
require 'parslet'

module WarRoom
  class ListParser < Parslet::Parser
    def self.section_repeat(rule_name, section_item)
      rule(rule_name) { (send(section_item) >> newline).repeat >> newline }
    end

    def parse(io, options = {})
      @result = super io, options
    rescue Parslet::ParseFailed => e
      raise InvalidListException
    else
      raise InvalidListException if @result[:warnoun].nil? && @result[:battle_engines].empty? && @result[:units].empty? && @result[:solos].empty?
      @result
    end

    rule(:number)              { match('\d').repeat(1, nil) }

    rule(:space)               { str(' ').repeat(1, nil) }
    rule(:before_hyphen)       { (hyphen.absent? >> match['^\r\n'] ).repeat(1, nil) }
    rule(:hyphen)              { space >> str('-') >> space }
    rule(:newline)             { str("\r\n") }
    rule(:empty_line)          { newline.repeat(2) }

    rule(:pc)                  { str('PC: ') >> number.as(:cost) }
    rule(:descriptor_and_cost) { ((str(':').maybe >> space >> number >> newline).absent? >> any).repeat(1, nil).as(:descriptor) >>
                                 str(':').maybe >> space >> number.as(:cost) }

    rule(:warroom_header)      { str('War Room Army') >> empty_line }

    rule(:faction)             { before_hyphen }
    rule(:title)               { match['^\n\r'].repeat(1, nil) }

    rule(:totals)              { number >> str(' / ') >> number >> space >> str('(') >> number >> str('+') >> number >> str(')') >> space >>
                                 (str('Warcaster(s)') | str('Warlock(s)')) >> space >> str(':') >> space >> number >> str('/') >> number >> space >>
                                 (str('Warjack(s)') | str('Warbeast(s)')) >> space >> str(':') >> space >> number >> space >>
                                 str('Battle Engines') >> space >> str(':') >> space >> number >> space >>
                                 str('Solos') >> space >> str(':') >> space >> number >> space >>
                                 str('Units') >> space >> str(':') >> space >> number >> empty_line }

    rule(:battlegroup_and_attachment) { warnoun.as(:warnoun) >>
                                        warnoun_attachment.maybe.as(:warnoun_attachment) >>
                                        warbjs.repeat(0,1).as(:warbjs) }


    rule(:warnoun)             { before_hyphen.as(:name) >> hyphen >> (str('WB: +') | str('WJ: +')) >> match('\d').repeat(1, nil).as(:points) >> newline }
    rule(:warnoun_attachment)  { str('-') >> space >> (match['^\r\n'] >> str('PC:').absent?).repeat(1, nil).as(:name) >> newline }
    rule(:warbj)               { str('-') >> space >> before_hyphen.as(:name) >> hyphen >> pc }
    section_repeat(:warbjs, :warbj)

    rule(:battle_engine)       { before_hyphen.as(:name) >> hyphen >> pc }
    section_repeat(:battle_engines, :battle_engine)

    rule(:solo)                { before_hyphen.as(:name) >> hyphen >> pc }
    section_repeat(:solos, :solo)

    rule(:unit)                { str('-').absent? >> before_hyphen.as(:name) >> hyphen >> (pc | descriptor_and_cost) >> (newline >> unit_attachment).repeat.as(:unit_attachments) }
    rule(:unit_attachment)     { str('-') >> space >> before_hyphen.as(:name) >> hyphen >> (pc | descriptor_and_cost) }
    section_repeat(:units, :unit)

    rule(:rest)                { any.repeat }

    # theme
    rule(:theme_header)        { str('THEME: ') >> before_hyphen.as(:name) >> hyphen >> str('Tier ') >> number.as(:tier) }
    rule(:allowed_models)      { ((empty_line >> str('TIER 1')).absent? >> any).repeat.as(:allowed_models) >> empty_line }
    rule(:tier)                { str('TIER ') >> number.as(:tier) >> (hyphen >> str('SELECTED').as(:selected)).maybe >> newline >>
                                 str('---Requirements---') >> newline >>
                                 ((newline >> str('---Benefits---')).absent? >> any).repeat(1, nil).as(:requirements) >> newline >>
                                 str('---Benefits---') >> newline >>
                                 (empty_line.absent? >> any).repeat(1, nil).as(:benefits) }
    rule(:tiers)               { (tier >> empty_line).repeat(1, nil) }
    rule(:theme)               { theme_header >>
                                 allowed_models >>
                                 tiers.as(:tiers) }

    rule(:warroom_list)        { warroom_header >>
                                 faction.as(:faction) >> hyphen >> title.as(:title) >> empty_line >>
                                 totals >>
                                 battlegroup_and_attachment.maybe >>
                                 battle_engines.repeat(0,1).as(:battle_engines) >>
                                 solos.repeat(0,1).as(:solos) >>
                                 units.repeat(0,1).as(:units) >>
                                 theme.maybe.as(:theme) >>
                                 str('--') >>
                                 rest }
    root :warroom_list
  end
end
