require 'war_room/list_parser'

module HeredocHelpers
  def doctor_heredoc string
    string.gsub(/(?<!\r)\n/, "\r\n").gsub(/^\ */, '')
  end
end

RSpec.configure do |config|
  config.include HeredocHelpers
end

