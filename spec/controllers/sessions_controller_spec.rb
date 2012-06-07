require 'spec_helper'
describe SessionsController, "GET new" do
	@ses = SessionsController.new
	it "renders the 'new' template" do
		get :new
		@ses.should render_template('new')
	end
end

describe SessionsController, "POST create" do
	before(:each) do
		@ses = SessionsController.new
	end
	it "redirect_to to_do_lists_path if valid login" do
		User.stub!(:authenticate_user).with('Shubham','123456').and_return(true)
		post :create, :user_name => "Shubham", :password => 123456
		@ses.should redirect_to(to_do_lists_path)
	end
	it "redirect_to login if invalid login" do
		User.stub!(:authenticate_user).with(anything(), anything()).and_return(false)
		post :create, :user_name => "Shubham", :password => 123
		@ses.should redirect_to('/login')
	end
	it "Shows error message if invalid login" do
		User.stub!(:authenticate_user).with(anything(), anything()).and_return(false)
		post :create, :user_name => "Shubham", :password => 123
		flash[:notice].should_not be_nil
	end
end

describe SessionsController, "DELETE destroy" do
	@ses = SessionsController.new
	it "sets user_id in session to nil" do
		delete :destroy
		session[:user_id].should be_nil
	end
end
