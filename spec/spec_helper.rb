require 'war_room/list_parser'

module HeredocHelpers
  def doctor_heredoc string
    string.gsub(/(?<!\r)\n/, "\r\n").gsub(/^\ */, '')
  end
end

module ListHelpers
  def create_list list_text
    WarRoom::ListParser::Transform.new.apply(WarRoom::ListParser::Parser.new.parse(list_text))
  end
end

RSpec.configure do |config|
  config.include HeredocHelpers
  config.include ListHelpers
end

