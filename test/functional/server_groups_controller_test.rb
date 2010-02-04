require 'test_helper'

class ServerGroupsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:server_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create server_group" do
    assert_difference('ServerGroup.count') do
      post :create, :server_group => { }
    end

    assert_redirected_to server_group_path(assigns(:server_group))
  end

  test "should show server_group" do
    get :show, :id => server_groups(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => server_groups(:one).to_param
    assert_response :success
  end

  test "should update server_group" do
    put :update, :id => server_groups(:one).to_param, :server_group => { }
    assert_redirected_to server_group_path(assigns(:server_group))
  end

  test "should destroy server_group" do
    assert_difference('ServerGroup.count', -1) do
      delete :destroy, :id => server_groups(:one).to_param
    end

    assert_redirected_to server_groups_path
  end
end
