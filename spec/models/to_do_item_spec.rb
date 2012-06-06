require 'spec_helper'
describe ToDoItem	do
	before(:each) do
		@to_do_item = ToDoItem.new(:subject => 'abc', :content => 'whgdshgdjsa',:remind_at =>'11:12:12', :remind_on => '2012-11-11', :priority => 'High')
	end
	it "is valid with valid attributes" do
		@to_do_item.should be_valid
	end	
	it "is valid if subject is not present" do
		@to_do_item.subject = nil
		@to_do_item.should be_valid
	end
	it "is valid if content is not present" do
		@to_do_item.content = ""
		@to_do_item.should be_valid
	end
	it "is valid if time is not present" do
		@to_do_item.remind_at = nil
		@to_do_item.should be_valid
	end
	it "is valid if date is not present" do
		@to_do_item.remind_on = nil
		@to_do_item.should be_valid
	end
	it "is invalid if priority is not on list" do
		@to_do_item.priority = 'Max'
		@to_do_item.should_not be_valid
	end
	it "is invalid if priority is not present" do
		@to_do_item.priority = nil
		@to_do_item.should_not be_valid
	end
end
