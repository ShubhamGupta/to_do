require 'spec_helper'
describe ToDoListsController , "POST create" do
	before (:each) do
		user = mock_model(User)
		@list = mock_model(ToDoList, :save => true)
		ToDoList.stub!(:user_id).and_return('1')
		controller.stub!(:current_user).and_return(user)#VIMP!!! stubing :before of controller
		@params={"name" => 'abc',
			"priority" => 'High',
		}
	end
	it "renders show when valid" do
		post :create , :to_do_list => @params
		ToDoList.should render_template('show')
	end	
	it "renders new when invalid" do
		post :create , :to_do_list => {"name" => 'abc', "priority" => 'Higher'}
		ToDoList.should render_template('new')
	end	
end
describe ToDoListsController, "PUT update" do
	before(:each) do
		@list = mock_model(ToDoList)
		ToDoList.stub!(:find).and_return(@list)
		user = mock_model(User)
		lists = mock_model(ToDoList)
		@list.stub!(:belongs_to_current_user?).and_return true
		ToDoList.stub!(:where).and_return(lists)
		controller.stub!(:current_user).and_return(user)
	end
	it "redirect_to index if valid" do
		
		@list.stub!(:update_attributes).and_return(true)
		put :update
		@list.should redirect_to(:action => 'index')
	end
	it "redirect_to edit if invalid" do
		@list.stub!(:update_attributes).and_return(false)
		put :update
		@list.should render_template(:action => 'edit')
	end
end
describe ToDoListsController , "GET index" do
	before (:each) do
		@list = mock_model(ToDoList)
		ToDoList.stub!(:where).and_return(@list)
	end
		it "redirect_to login if not logged in" do
			session[:user_id]='101'
			get :index
			@list.should redirect_to("/login")
		end
	
		it "renders index if valid" do
			user = mock_model(User)
			controller.stub!(:current_user).and_return(user)#VIMP!!! stubing :before of controller
			get :index
			@list.should render_template('index')
		end
	end

describe ToDoListsController , "GET show" do
	before (:each) do
		@list = mock_model(ToDoList)
		@list.stub!(:user_id).and_return 1
		ToDoList.stub!(:find).and_return(@list)
	end
		it "redirect_to to_do_lists_path if list doesn't matches user" do
			#session[:user_id]='1'
			user = mock_model(User, :id => '2')
			controller.stub!(:current_user).and_return(user)#VIMP!!! stubing :before of controller
			get :show
			@list.should redirect_to(to_do_lists_path)
		end
		
		it "render show if valid" do
			list = mock_model(ToDoList)
			session[:user_id]='1'
			get :show, :id => '1'
			@list.should render_template('show')
		end
		it "redirect_to login page if invalid user" do
			session[:user_id]='101'
			get :show
			@list.should redirect_to('/login')
		end
	end
describe ToDoListsController , "GET new" do
	before(:each) do
		@list = mock_model(ToDoList)
		user = mock_model(User)
		controller.stub!(:current_user, :id =>1).and_return(user)#VIMP!!! stubing :before of controller
		get :new
	end
	it "creates a new list" do
		@list.should_not be_nil
	end
	it "renders the new list page" do
		@list.should render_template("new")
	end
end
describe ToDoListsController , "PUT edit" do
	before(:each) do
		@list = mock_model(ToDoList)
		session[:user_id]='1'
	end
	it "redirect_to to_do_lists_path if list isn't found" do
		put :edit , :id => '101'
		@list.should redirect_to(to_do_lists_path)
	end
	
	it "redirect_to to_do_lists_path if list is not of current_user" do
		put :edit , :id => '5'
		@list.should redirect_to(to_do_lists_path)
	end
	it "renders the edit list page if valid" do
		put :edit , :id => '1'
		@list.should render_template("edit")
	end
end

describe ToDoListsController , "DELETE destroy" do
	before(:each) do
		@list = mock_model(ToDoList)
		session[:user_id]='1'
		
	end
	it "sets flash if list is found" do
		delete :destroy , :id => '1'
		flash.now[:notice].should be_nil
	end
	it "Sets flash if list isn't found" do
		delete :destroy , :id => '101'
		flash[:notice].should_not be_nil
	end
	it "Should redirect_to to_do_lists_path " do
		delete :destroy , :id => '101'
		@list.should redirect_to(to_do_lists_path)
	end
	
end
