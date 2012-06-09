class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  before_filter :current_user, :except => [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
  private
  def redirect_if_not_found
  	@user = current_user
  	redirect_to controller: "to_do_lists", action: 'index'#, id: @user.id
  end
  public
  def index
  	@user = current_user
    render 'show'#, :id => @user.id  
  end

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
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
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
        format.html { redirect_to to_do_lists_path, notice: "You have been registered. An email has been 												sent to the email id you provided for more information."}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  

  # DELETE /users/1
  # DELETE /users/1.json
  
end
