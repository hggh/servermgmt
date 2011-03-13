require 'test_helper'

class SshkeysControllerTest < ActionController::TestCase
  setup do
    @sshkey = sshkeys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sshkeys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sshkey" do
    assert_difference('Sshkey.count') do
      post :create, :sshkey => @sshkey.attributes
    end

    assert_redirected_to sshkey_path(assigns(:sshkey))
  end

  test "should show sshkey" do
    get :show, :id => @sshkey.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sshkey.to_param
    assert_response :success
  end

  test "should update sshkey" do
    put :update, :id => @sshkey.to_param, :sshkey => @sshkey.attributes
    assert_redirected_to sshkey_path(assigns(:sshkey))
  end

  test "should destroy sshkey" do
    assert_difference('Sshkey.count', -1) do
      delete :destroy, :id => @sshkey.to_param
    end

    assert_redirected_to sshkeys_path
  end
end
