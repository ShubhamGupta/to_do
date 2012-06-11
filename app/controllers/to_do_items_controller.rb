class ToDoItemsController < ApplicationController
  # GET /to_do_items
  # GET /to_do_items.json
  before_filter :current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :redirect_if_not_found
  
  def index
		redirect_to to_do_list_path(params[:to_do_list_id])
	end

  # GET /to_do_items/1
  # GET /to_do_items/1.json
  def show
  	@to_do_item = ToDoItem.find(params[:id])
  	redirect_to to_do_lists_path, notice: "item not found" unless @to_do_item.belongs_to_current_user?(current_user)
  end

  # GET /to_do_items/new
  # GET /to_do_items/new.json
  def new
		@to_do_list = ToDoList.find(params[:to_do_list_id])
 			redirect_to to_do_lists_path if @to_do_list.user_id != current_user.id
 		@to_do_item = ToDoItem.new
  end

  # GET /to_do_items/1/edit
  def edit
		@to_do_list = ToDoList.find(params[:to_do_list_id])
	  @to_do_item = ToDoItem.find(params[:id])
	  redirect_to to_do_lists_path, notice: "Item not found" unless @to_do_item.belongs_to_current_user?(current_user)
  end

  # POST /to_do_items
  # POST /to_do_items.json
  def create
  	@to_do_list = ToDoList.find(params[:to_do_list_id])
    @to_do_item = ToDoItem.new(params[:to_do_item])
    @to_do_list.to_do_items.build(params[:to_do_item])
		respond_to do |format|
      if @to_do_list.save
        format.html { redirect_to to_do_list_to_do_items_path(@to_do_item.to_do_list_id), notice: 'To do item was successfully created.' }
        format.json { render json: @to_do_item, status: :created, location: @to_do_item }
      else
        format.html { 
        	render action: "new" 
        }
        format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /to_do_items/1
  # PUT /to_do_items/1.json
  def update
 # render text: "HERE"
  begin
    @to_do_list = ToDoList.find(params[:to_do_list_id])
    @to_do_item = ToDoItem.find(params[:id])
		respond_to do |format|
      if @to_do_item.update_attributes(params[:to_do_item])
        format.html { redirect_to action: 'index' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @to_do_item.errors, status: :unprocessable_entity }
      end
    end
   rescue ActiveRecord::RecordNotFound
   	 redirect_to action: 'index'
   end
  end

  # DELETE /to_do_items/1
  # DELETE /to_do_items/1.json
  def destroy
    	@to_do_item = ToDoItem.find(params[:id])
    	@to_do_item.destroy
			respond_to do |format|
      	format.html { redirect_to :action => 'index', :to_do_list_id => @to_do_item.to_do_list_id} #to_do_list_to_do_items_path(@to_do_item.to_do_list_id)}
      	format.json { head :no_content }
    	end
  end
  
  private
  def redirect_if_not_found
  	@user = current_user
  	redirect_to to_do_lists_path, notice: 'Requested resource does not exists.'
  end
end
