class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  layout 'application'
  layout 'session', :only=> :new
  before_filter :current_user, :except => [:new, :create]
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
  	begin
    	@user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    	@user = current_user
    	redirect_to controller: "to_do_lists", action: 'index'#, id: @user.id
    end
    	
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
      session[:user_id] = @user.id
        format.html { redirect_to to_do_lists_path}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
  	begin
    	@user = User.find(params[:id])

		  respond_to do |format|
		    if @user.update_attributes(params[:user])
		      format.html { redirect_to @user, notice: 'User was successfully updated.' }
		      format.json { head :no_content }
		    else
		      format.html { render action: "edit" }
		      format.json { render json: @user.errors, status: :unprocessable_entity }
		    end
		  end
		 rescue ActiveRecord::RecordNotFound
		 	 @user = current_user
		 	 redirect_to controller: "to_do_lists", action: 'index', id: @user.id
		 end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  begin
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  rescue ActiveRecord::RecordNotFound
  	@user = current_user
  	redirect_to controller: "to_do_lists", action: 'index', id: @user.id
  end
  end
  
end
