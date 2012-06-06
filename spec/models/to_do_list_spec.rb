require 'spec_helper'
describe ToDoList	do
	before(:each) do
		@to_do_list = ToDoList.new(:name => 'a', :priority => 'High')
	end
	it "is valid with valid attributes" do
		@to_do_list.should be_valid
	end	
	it "is invalid if name is not present" do
		@to_do_list.name = nil
		@to_do_list.should_not be_valid
	end
	
	it "is invalid if priority is not on list" do
		@to_do_list.priority = 'Max'
		@to_do_list.should_not be_valid
	end
end
