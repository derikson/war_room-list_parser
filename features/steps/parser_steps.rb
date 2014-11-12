Given(/^a list of:$/) do |string|
  @list = string.gsub(/(?<!\r)\n/, "\r\n")
end


When(/^I parse the list$/) do
  @parsed_list = nil
  begin
    @parsed_list = WarRoom::ListParser.new.parse(@list)
  rescue WarRoom::ListParser::InvalidListException => e
    @invalid_list_exception = true
  else
    @invalid_list_exception = false
  end
end


Then(/^an InvalidListException should be thrown$/) do
  expect(@invalid_list_exception).to eq(true)
end


Then(/^I should get a parsed list$/) do
  expect(@parsed_list).to_not be_nil
end


Then(/^I should get (\d+) warnouns?$/) do |n|
  case n.to_i
  when 0 then expect(@parsed_list[:warnoun]).to     be_nil
  when 1 then expect(@parsed_list[:warnoun]).to_not be_nil
  else pending
  end
end


Then(/^I should not get a warnoun attachment$/) do
  expect(@parsed_list[:warnoun_attachment]).to be_nil
end


Then(/^I should get a warnoun attachment$/) do
  expect(@parsed_list[:warnoun_attachment]).to_not be_nil
end


Then(/^I should get (\d+) warbjs?$/) do |n|
  expect(@parsed_list[:warbjs].length).to eq(n.to_i)
end


Then(/^I should get (\d+) battle engines?$/) do |n|
  expect(@parsed_list[:battle_engines].length).to eq(n.to_i)
end


Then(/^I should get (\d+) solos?$/) do |n|
  expect(@parsed_list[:solos].length).to eq(n.to_i)
end


Then(/^I should get (\d+) solo attachments?$/) do |n|
  expect(@parsed_list[:solos].map { |u| u[:solo_attachments] }.flatten.length).to eq(n.to_i)
end


Then(/^I should get (\d+) units?$/) do |n|
  expect(@parsed_list[:units].length).to eq(n.to_i)
end


Then(/^I should get (\d+) unit attachments?$/) do |n|
  expect(@parsed_list[:units].map { |u| u[:unit_attachments] }.flatten.length).to eq(n.to_i)
end
