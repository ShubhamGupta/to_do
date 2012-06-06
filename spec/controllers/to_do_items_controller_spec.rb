require 'spec_helper'
describe ToDoItemsController , "POST create" do
	before (:each) do
		@item = mock_model(ToDoItem, :save => true)
		ToDoItem.stub!(:user_id).and_return('1')
		@params={"subject" => 'abc',
			"content" => 'xyz',
			"remind_on" => '2012-01-01',
			"remind_at" => '11:11:11',
			"priority" => 'High'
		}
	end
	
end

describe ToDoItemsController, "GET index" do
	it "redirect_to corresponding list" do
		session[:user_id] = 1
		@to_do_item = mock_model(ToDoItem)
		get :index , :to_do_list_id => 1
		@to_do_item.should redirect_to(to_do_list_path(1))
	end
end
describe ToDoItemsController, "GET show" do
	before(:each) do
			@to_do_item = mock_model(ToDoItem)
			session[:user_id] = 1
	end
	it "redirect_to to_do_lists_path if item is invalid" do
		get :show , :to_do_list_id => 101
		@to_do_item.should redirect_to(to_do_lists_path)
	end
	it "redirect_to login page if user is not logged in" do
		session[:user_id]=1786
		get :show , :id => 39
		@to_do_item.should redirect_to('/login')
	end
	it "renders show if valid" do
		get :show , :id => 39
		@to_do_item.should render_template('show')
	end
end

describe ToDoItemsController, "GET new" do
	before(:each) do
			@to_do_item = mock_model(ToDoItem)
			session[:user_id] = 1
	end
	it "should create a new item" do
		@to_do_item.should_not be_nil
	end
	it "redirect_to index if list doesn't belong to logged in user" do
		get :new, :to_do_list_id => 5
		@to_do_item.should redirect_to(to_do_lists_path)
	end
	it "redirect_to login page if user is not logged in" do
		session[:user_id]=1786
		get :new , :to_do_list_id => 1
		@to_do_item.should redirect_to('/login')
	end
end

describe ToDoItemsController , "PUT edit" do
	before(:each) do
		@item = mock_model(ToDoItem)
		session[:user_id]='1'
	end
	it "redirect_to to_do_lists_path if list isn't found" do
		put :edit , :id => '39', :to_do_list_id => 100
		@item.should redirect_to(to_do_lists_path)
	end
	
	it "redirect_to to_do_lists_path if item isn't found" do
		put :edit , :id => '30', :to_do_list_id => 1
		@item.should redirect_to(to_do_lists_path)
	end
	
	it "redirect_to index if list doesnt belong to current_user" do
		put :edit , :id => '40', :to_do_list_id => 1
		@item.should redirect_to(to_do_lists_path)
	end
	it "renders edit if valid" do
		put :edit , :id => '39', :to_do_list_id => 1
		@item.should render_template('edit')
	end
end

describe ToDoListsController , "DELETE destroy" do
	before(:each) do
		@item = mock_model(ToDoItem)
		session[:user_id]='1'
	end
	it "renders index if invalid" do
		delete :destroy, :id => 392
		@item.should redirect_to to_do_lists_path
	end	
	
end
