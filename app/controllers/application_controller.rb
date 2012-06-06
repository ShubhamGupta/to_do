class ApplicationController < ActionController::Base
  protect_from_forgery
  private 

  def current_user
  	begin
      User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
    	redirect_to :controller => 'sessions', :action => 'new'
    end
end
end
