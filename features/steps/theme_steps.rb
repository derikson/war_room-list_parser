Then(/^I should not get a theme$/) do
  expect(@parsed_list.theme).to be_nil
end

Then(/^I should get a theme called "(.*?)"$/) do |name|
  expect(@parsed_list.theme.name).to eq(name)
end


Then(/^I should get a theme that is tier (\d+)$/) do |n|
  expect(@parsed_list.theme.tier).to eq(4)
end


Then(/^I should get the following allowed models$/) do |string|
  expect(@parsed_list.theme.allowed_models).to eq(string.gsub(/(?<!\r)\n/, "\r\n"))
end


Then(/^I should get a tier with requirements "(.*?)" and benifits "(.*?)"$/) do |reqs, bens|
  expect(@parsed_list.theme.tiers.find { |t| t.requirements == reqs && t.benefits == bens }).to_not be_nil
end


Then(/^I should get a (?:contract|pact) called "(.*?)"$/) do |contract_or_pact|
  expect(@parsed_list.contract_or_pact).to eq(contract_or_pact)
end
