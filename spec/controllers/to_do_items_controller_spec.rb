require 'spec_helper'
describe ToDoItemsController , "POST create" do
	before (:each) do
		@item = mock_model(ToDoItem)
		items = mock_model(ToDoItem)
		user = mock_model(User)
		@list = mock_model(ToDoList)
		@list.stub!(:to_do_items).and_return items
		items.stub!(:build)
		ToDoList.stub!(:find).and_return(@list)
		ToDoItem.stub!(:new).and_return(@item)
		controller.stub!(:current_user).and_return(user)#VIMP!!! stubing :before of controller
	end
	it "redirects to lists path when valid" do
		@list.stub!(:save).and_return(true)
		post :create , :to_do_list_id => 1 
		ToDoList.should redirect_to('/to_do_lists/1/to_do_items')
	end
	it "renders new when invalid" do
		@list.stub!(:save).and_return(false)
		post :create# , :to_do_list_id =>1
		ToDoList.should render_template('new')
	end
end

describe ToDoItemsController, "PUT update" do
	before(:each) do
		@list = mock_model(ToDoList)
		user = mock_model(User) 
		@item = mock_model(ToDoItem)
		ToDoItem.stub!(:find).and_return(@item)
		ToDoList.stub!(:find).and_return(@list)
		controller.stub!(:current_user).and_return(user)#VIMP!!! stubing :before of controller
	end
	it "redirects to index if update is successful" do
		@item.stub!(:update_attributes).and_return(true)
		put :update
		@item.should redirect_to(action: 'index')
	end
	it "redirects to index if update is successful" do
		@item.stub!(:update_attributes).and_return(false)
		put :update
		@item.should render_template('edit')
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
	it "shows flash message if invalid" do
		get :show , :to_do_list_id => 101
		flash[:notice].should_not be_nil
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

describe ToDoItemsController , "GET edit" do
	before(:each) do
		@item = mock_model(ToDoItem)
		session[:user_id]='1'
	end
	it "redirect_to to_do_lists_path if list isn't found" do
		get :edit , :id => '39', :to_do_list_id => 100
		@item.should redirect_to(to_do_lists_path)
	end
	
	it "redirect_to to_do_lists_path if item isn't found" do
		get :edit , :id => '30', :to_do_list_id => 1
		@item.should redirect_to(to_do_lists_path)
	end
	
	it "redirect_to index if list doesnt belong to current_user" do
		get :edit , :id => '40', :to_do_list_id => 1
		@item.should redirect_to(to_do_lists_path)
	end
	it "renders edit if valid" do
		get :edit , :id => '39', :to_do_list_id => 1
		@item.should render_template('edit')
	end
end

describe ToDoItemsController , "DELETE destroy" do
	before(:each) do
		@item = mock_model(ToDoItem)
		ToDoItem.stub!(:find).and_return(@item)
		user = mock_model(User)
		@item.stub!(:destroy).and_return(true)
		controller.stub!(:current_user).and_return(user)#VIMP!!! stubing :before of controller
	end
	it "renders index" do
		delete :destroy#, :id => 392
		@item.should redirect_to  :action => 'index'
	end	
	
end

