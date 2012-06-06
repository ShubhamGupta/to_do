require 'test_helper'

class ToDoListsControllerTest < ActionController::TestCase
  setup do
    @to_do_list = to_do_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:to_do_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create to_do_list" do
    assert_difference('ToDoList.count') do
      post :create, to_do_list: {  }
    end

    assert_redirected_to to_do_list_path(assigns(:to_do_list))
  end

  test "should show to_do_list" do
    get :show, id: @to_do_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @to_do_list
    assert_response :success
  end

  test "should update to_do_list" do
    put :update, id: @to_do_list, to_do_list: {  }
    assert_redirected_to to_do_list_path(assigns(:to_do_list))
  end

  test "should destroy to_do_list" do
    assert_difference('ToDoList.count', -1) do
      delete :destroy, id: @to_do_list
    end

    assert_redirected_to to_do_lists_path
  end
end
