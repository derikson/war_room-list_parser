Given(/^a list of:$/) do |string|
  @list = string.gsub(/(?<!\r)\n/, "\r\n")
end


When(/^I parse the list$/) do
  @parsed_list = nil
  begin
    @parsed_list = WarRoom::ListParser.parse(@list)
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
  when 0 then expect(@parsed_list.warnoun).to     be_nil
  when 1 then expect(@parsed_list.warnoun).to_not be_nil
  else pending
  end
end

Then(/^I should get a warnoun with a name of "(.*?)" and (\d+) points$/) do |name, points|
  expect(@parsed_list.warnoun.name  ).to eq(name)
  expect(@parsed_list.warnoun.points).to eq(points.to_i)
end


Then(/^I should get 1 warnoun called "(.*?)"$/) do |name|
  expect(@parsed_list.warnoun.name).to eq(name)
end


Then(/^I should not get a warnoun attachment$/) do
  expect(@parsed_list.warnoun && @parsed_list.warnoun.attachment).to be_nil
end


Then(/^I should get a warnoun attachment$/) do
  expect(@parsed_list.warnoun && @parsed_list.warnoun.attachment).to_not be_nil
end


Then(/^I should get a warnoun attachment called "(.*?)"$/) do |attachment|
  expect(@parsed_list.warnoun && @parsed_list.warnoun.attachment).to eq(attachment)
end


Then(/^I should get (\d+) warbjs?$/) do |n|
  expect(@parsed_list.warnoun ? @parsed_list.warnoun.warbjs.length : 0).to eq(n.to_i)
end


Then(/^I should get a warbj with a name of "(.*?)" and a cost of (\d+)$/) do |name, cost|
  expect(@parsed_list.warnoun.warbjs.find { |warbj| warbj.name == name && warbj.cost == cost.to_i }).to_not be_nil
end


Then(/^I should get (\d+) battle engines?$/) do |n|
  expect(@parsed_list.battle_engines.length).to eq(n.to_i)
end


Then(/^i should get a battle engine with a name of "(.*?)" and a cost of (\d+)$/) do |name, cost|
  expect(@parsed_list.battle_engines.find { |b| b.name == name && b.cost == cost.to_i }).to_not be_nil
end


Then(/^I should get (\d+) solos?$/) do |n|
  expect(@parsed_list.solos.length).to eq(n.to_i)
end


Then(/^I should get a solo with a name of "(.*?)" and a cost of (\d+)$/) do |name, cost|
  expect(@parsed_list.solos.find { |b| b.name == name && b.cost == cost.to_i }).to_not be_nil
end


Then(/^I should get (\d+) solo attachments?$/) do |n|
  expect(@parsed_list.solos.map(&:attachments).flatten.length).to eq(n.to_i)
end


Then(/^I should get a solo attachment with a name of "(.*?)" and a cost of (\d+)$/) do |name, cost|
  expect(@parsed_list.solos.map(&:attachments).flatten.find { |a| a.name == name && a.cost == cost.to_i }).to_not be_nil
end


Then(/^I should get (\d+) units?$/) do |n|
  expect(@parsed_list.units.length).to eq(n.to_i)
end


Then(/^I should get a unit with a name of "(.*?)", an descriptor of "(.*?)", and a cost of (\d+)$/) do |name, descriptor, cost|
  expect(@parsed_list.units.find { |u| u.name == name && u.descriptor == descriptor && u.cost == cost.to_i }).to_not be_nil
end


Then(/^I should get (\d+) unit attachments?$/) do |n|
  expect(@parsed_list.units.map(&:attachments).flatten.length).to eq(n.to_i)
end


Then(/^I should get a unit attachment with a name of "(.*?)", a descriptor of "(.*?)", and a cost of (\d+)$/) do |name, descriptor, cost|
  expect(@parsed_list.units.map(&:attachments).flatten.find { |u| u.name == name && u.descriptor == descriptor && u.cost == cost.to_i }).to_not be_nil
end


Then(/^I should get a list title of "(.*?)"$/) do |title|
  expect(@parsed_list.title).to eq(title)
end


Then(/^I should get a faction of "(.*?)"$/) do |faction|
  expect(@parsed_list.faction).to eq(faction)
end


Then(/^I should get a list with a point level of (\d+)$/) do |n|
  expect(@parsed_list.point_level).to eq(n.to_i)
end


Then(/^I should get a list with (\d+) points$/) do |n|
  expect(@parsed_list.points).to eq(n.to_i)
end


Then(/^I should get a list with a max points of (\d+)$/) do |n|
  expect(@parsed_list.max_points).to eq(n.to_i)
end


Then(/^I should get a list (\d+) warbj points$/) do |n|
  expect(@parsed_list.warbj_points).to eq(n.to_i)
end
