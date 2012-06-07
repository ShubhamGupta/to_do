require 'spec_helper'
describe User	do
	before(:each) do
		@user = User.new(:first_name => 'a', :last_name  => 'b', :user_name => 'abcdefs', :email_id => 'shubham_mait89@yahoo.com', :password => '782163782163871')
		
	end
	it "is valid with valid attributes" do
		@user.should be_valid
	end
	it "is invalid if first_name is not present" do
		@user.first_name = nil
		@user.should_not be_valid
	end
	
	it "is invalid if email_id is not present" do
		@user.email_id = nil
		@user.should_not be_valid
	end
	it "is invalid if password is not present" do
		@user.password = nil
		@user.should_not be_valid
	end
	it "is invalid if password's length is less than 6 chars" do
		@user.password = '123'
		@user.should_not be_valid
	end
	it "should authenticate if username and password matches" do
		User.authenticate_user('Shubham','123456').should be_true
	end
	it "should not authenticate if username and password doesn't matches" do
		User.authenticate_user('abcd','123456').should be_false
	end
	it "has many lists" do
		
	end
end
