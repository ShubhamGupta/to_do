require 'spec_helper'

describe SessionsController, "Sessions Controller" do
  # @ses = SessionsController.new
  it "should show login page to user" do
    get :new
    response.should render_template('new')
  end
end

describe SessionsController, "Session Controller" do
  before(:each) do
    @user = mock_model(User)
  end
  
  it "should redirect_to to_do_lists_path if valid login" do
    User.should_receive(:authenticate_user).with('Shubham', '123456').and_return(true)
    User.should_receive(:find_by_user_name).with('Shubham').and_return(@user)
    @user.should_receive(:id).and_return('1')
    post :create, :user_name => "Shubham", :password => '123456'
    session[:user_id].should == '1'
    response.should redirect_to(to_do_lists_path)
  end
  
  it "should redirect_to login page & display error message if user enters invalid username/password" do
    User.should_receive(:authenticate_user).with('Shubham', '123').and_return(false)
    post :create, :user_name => "Shubham", :password => '123'
    flash[:notice].should == "Invalid User Name or Password"
    response.should redirect_to :action => :new
  end
end

describe SessionsController, "Session Controller" do
  before(:each) do
    @user = mock_model(User)
  end
  
  it "should sets user_id in session to nil and redirect to login page ie; allows user to log-out on clicking logout link" do
    User.should_receive(:find).and_return(@user)
    delete :destroy
    session[:user_id].should be_nil
    response.should redirect_to('/login')
  end
end