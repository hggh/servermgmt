require 'test_helper'

class SshkeyGroupsControllerTest < ActionController::TestCase
  setup do
    @sshkey_group = sshkey_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sshkey_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sshkey_group" do
    assert_difference('SshkeyGroup.count') do
      post :create, :sshkey_group => @sshkey_group.attributes
    end

    assert_redirected_to sshkey_group_path(assigns(:sshkey_group))
  end

  test "should show sshkey_group" do
    get :show, :id => @sshkey_group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sshkey_group.to_param
    assert_response :success
  end

  test "should update sshkey_group" do
    put :update, :id => @sshkey_group.to_param, :sshkey_group => @sshkey_group.attributes
    assert_redirected_to sshkey_group_path(assigns(:sshkey_group))
  end

  test "should destroy sshkey_group" do
    assert_difference('SshkeyGroup.count', -1) do
      delete :destroy, :id => @sshkey_group.to_param
    end

    assert_redirected_to sshkey_groups_path
  end
end
