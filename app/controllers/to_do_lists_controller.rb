class ToDoListsController < ApplicationController
  # GET /to_do_lists
  # GET /to_do_lists.json
  before_filter :current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
  
  def index
  	@user = current_user
  	@to_do_lists = ToDoList.where(:user_id => @user.id)
		respond_to do |format|
    	format.html # index.html.erb
    	format.json { render json: @to_do_lists }
    end
  end

  # GET /to_do_lists/1
  # GET /to_do_lists/1.json
  def show
		@to_do_list = ToDoList.find(params[:id])
	 	if(@to_do_list.user_id == current_user.id)
		  respond_to do |format|
		    format.html # show.html.erb
		    format.json { render json: @to_do_list }
		    end
		else
		 	redirect_to to_do_lists_path
		end
  end
	# GET /to_do_lists/new
  # GET /to_do_lists/new.json
  def new
    @to_do_list = ToDoList.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @to_do_list }
    end
  end

  # GET /to_do_lists/1/edit
  def edit
    @to_do_list = ToDoList.find(params[:id])
   	redirect_to to_do_lists_path if(@to_do_list.user_id != current_user.id)
  end

  # POST /to_do_lists
  # POST /to_do_lists.json
  def create
    @to_do_list = ToDoList.new(params[:to_do_list])
    @to_do_list.user_id = current_user.id
    respond_to do |format|
      if @to_do_list.save
      	format.html { 
        	flash[:notice]="To do list was successfully created."
        	render 'show'
        }
        format.json { render json: @to_do_list, status: :created, location: @to_do_list }
      else
        format.html { render action: "new" }
        format.json { render json: @to_do_list.errors, status: :unprocessable_entity }
      end
    end
  end

	# PUT /to_do_lists/1
  # PUT /to_do_lists/1.json
  def update
  	@to_do_list = ToDoList.find(params[:id])
  	@user = current_user
		respond_to do |format|
			if @to_do_list.belongs_to_current_user?(current_user)
			  if @to_do_list.update_attributes(params[:to_do_list])
			    format.html {
			    	redirect_to action: 'index'
			    }
			    format.json { head :no_content }
			  else
			    format.html { 
			    	flash[:notice] = "Error updating #{@to_do_list.name}."
			    	render action: "edit" 
			    }
			  end
			end
  	end
  end

  # DELETE /to_do_lists/1
  # DELETE /to_do_lists/1.json
  def destroy
  	@to_do_list = ToDoList.find(params[:id])
  	@to_do_list.destroy if @to_do_list.belongs_to_current_user?(current_user)
	  redirect_to to_do_lists_url
  end
  
  private
  def redirect_if_not_found
  	@user = current_user
  	redirect_to to_do_lists_path, notice: 'Requested resource does not exists.'
  end
end
