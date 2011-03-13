require 'test_helper'

class SshusersControllerTest < ActionController::TestCase
  setup do
    @sshuser = sshusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sshusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sshuser" do
    assert_difference('Sshuser.count') do
      post :create, :sshuser => @sshuser.attributes
    end

    assert_redirected_to sshuser_path(assigns(:sshuser))
  end

  test "should show sshuser" do
    get :show, :id => @sshuser.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sshuser.to_param
    assert_response :success
  end

  test "should update sshuser" do
    put :update, :id => @sshuser.to_param, :sshuser => @sshuser.attributes
    assert_redirected_to sshuser_path(assigns(:sshuser))
  end

  test "should destroy sshuser" do
    assert_difference('Sshuser.count', -1) do
      delete :destroy, :id => @sshuser.to_param
    end

    assert_redirected_to sshusers_path
  end
end
