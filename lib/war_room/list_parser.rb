require 'war_room/list_parser/version'
require 'war_room/list_parser/invalid_list_exception'
require 'war_room/list_parser/parser'
require 'parslet'

module WarRoom
  class ListParser
    def self.parse(io, options = {})
      @result = WarRoom::ListParser::Parser.new.parse io, options
    rescue Parslet::ParseFailed => e
      raise InvalidListException
    else
      raise InvalidListException unless @result[:warnoun] || @result[:battle_engines] || @result[:units] || (@result[:solos] && !@result[:solos].empty?)
      @result[:warbjs]         ||= []
      @result[:battle_engines] ||= []
      @result[:solos]          ||= []
      @result[:units]          ||= []
      @result
    end
  end
end
