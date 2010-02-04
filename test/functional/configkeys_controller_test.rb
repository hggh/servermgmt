require 'test_helper'

class ConfigkeysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:configkeys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create configkey" do
    assert_difference('Configkey.count') do
      post :create, :configkey => { }
    end

    assert_redirected_to configkey_path(assigns(:configkey))
  end

  test "should show configkey" do
    get :show, :id => configkeys(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => configkeys(:one).to_param
    assert_response :success
  end

  test "should update configkey" do
    put :update, :id => configkeys(:one).to_param, :configkey => { }
    assert_redirected_to configkey_path(assigns(:configkey))
  end

  test "should destroy configkey" do
    assert_difference('Configkey.count', -1) do
      delete :destroy, :id => configkeys(:one).to_param
    end

    assert_redirected_to configkeys_path
  end
end
