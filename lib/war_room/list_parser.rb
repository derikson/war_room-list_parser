require 'war_room/list_parser/version'
require 'war_room/list_parser/invalid_list_exception'
require 'war_room/list_parser/list'
require 'war_room/list_parser/list/warnoun'
require 'war_room/list_parser/list/warbj'
require 'war_room/list_parser/list/battle_engine'
require 'war_room/list_parser/list/solo'
require 'war_room/list_parser/list/solo_attachment'
require 'war_room/list_parser/list/unit'
require 'war_room/list_parser/list/unit_attachment'
require 'war_room/list_parser/parser'
require 'war_room/list_parser/transform'
require 'parslet'

module WarRoom
  class ListParser
    def self.parse(io, options = {})
      WarRoom::ListParser::Transform.new.apply(WarRoom::ListParser::Parser.new.parse(io, options))
    rescue Parslet::ParseFailed => e
      raise InvalidListException
    end
  end
end
