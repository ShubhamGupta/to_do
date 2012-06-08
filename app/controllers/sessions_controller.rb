class SessionsController < ApplicationController
	layout 'session'
  before_filter :current_user, :only => ['destroy']

  def create
  user_name = params[:user_name]
	password = params[:password]
	if User.authenticate_user(user_name,password)
		@user = User.find_by_user_name(user_name)
		session[:user_id]=@user.id
		redirect_to to_do_lists_path#controller: 'to_do_lists', action: 'index', id: @user.id
	else
		flash[:notice]="Invalid User Name or Password"
		redirect_to action: 'new'
	end
  end
	def destroy
	  session[:user_id] = nil
	  redirect_to '/login'
	end
end
