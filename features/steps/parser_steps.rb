Given(/^a list of:$/) do |string|
  @list = string
end

When(/^I parse the list$/) do
  begin
    @result = WarRoom::ListParser.new.parse(@list)
  rescue WarRoom::ListParser::InvalidListException => e
    @invalid_list_exception = true
  else
    @invalid_list_exception = false
  end
end

Then(/^an InvalidListException should be thrown$/) do
  @invalid_list_exception
end

Then(/^I should get a parsed list$/) do
  @result
end
