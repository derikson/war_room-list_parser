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
  @invalid_list_exception.should == true
end

Then(/^I should get a parsed list$/) do
  @parsed_list.should_not == nil
end
