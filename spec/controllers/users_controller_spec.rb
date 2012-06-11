require 'spec_helper'
describe UsersController , "POST create" do
	before (:each) do
		@user = mock_model(User, :id => '1', :save => true)
		User.stub!(:new).and_return(@user)
		@params={"first_name" => 'abc',
			"last_name" => 'def',
			"email_id" => 'abdhj',
			"password" => '1256',
			"user_name" => 'Shubham'
		}
	end
	def do_post
		post :create, :user => @params
	end
	it "calls user model with param values" do
		User.should_receive(:new).and_return(@user)#.with(@params).and_return(@user)
		do_post
	end
	
	it "should redirect_to to_do_lists_path" do
		do_post
		User.should redirect_to(to_do_lists_path)
	end
	
	it "should render new if failed" do
		@user.stub(:save => false)
		do_post
		User.should render_template('new')
	end
	
end

describe UsersController , "GET show " do
	before (:each) do
		@user = mock_model(User)
	end
	it 'redirects to to_do_lists_path if user is valid' do
		session[:user_id]='1'
		get :show
		User.should redirect_to(to_do_lists_path)	
	end
	it 'redirects login page if user is invalid' do
		session[:user_id]='101'
		get :show
		User.should redirect_to(controller: 'sessions', action: 'new')	
	end
end

describe UsersController , "GET new" do
	before(:each) do
		@user = mock_model(User)
		get :new
	end
	it "creates a new user" do
		@user.should_not be_nil
	end
	it "renders the new user page" do
		@user.should render_template("new")
	end
end
describe UsersController, "GET edit" do
	it "renders edit" do
		@user = mock_model(User)
		User.stub!(:find).and_return(@user)
		controller.stub!(:current_user).and_return(@user)
		get :edit
		@user.should render_template('edit')
	end
end
