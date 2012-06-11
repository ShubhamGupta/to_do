class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :current_user, :except => [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found

  # GET /users/1
  # GET /users/1.json
  def show
		@user = current_user
		redirect_to to_do_lists_path
  end
  
	# GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    	@user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
      session[:user_id] = @user.id
      Notifier.registered(@user).deliver
        format.html { redirect_to to_do_lists_path, notice: "You have been registered. An email has been sent to the email id you provided for more information."}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render "new" }
      end
    end
  end
  
  private
  def redirect_if_not_found
  	@user = current_user
  	redirect_to controller: "to_do_lists", action: 'index'#, id: @user.id
  end
  
end
