require 'test_helper'

class ServeroperationsystemsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:serveroperationsystems)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_serveroperationsystem
    assert_difference('Serveroperationsystem.count') do
      post :create, :serveroperationsystem => { }
    end

    assert_redirected_to serveroperationsystem_path(assigns(:serveroperationsystem))
  end

  def test_should_show_serveroperationsystem
    get :show, :id => serveroperationsystems(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => serveroperationsystems(:one).id
    assert_response :success
  end

  def test_should_update_serveroperationsystem
    put :update, :id => serveroperationsystems(:one).id, :serveroperationsystem => { }
    assert_redirected_to serveroperationsystem_path(assigns(:serveroperationsystem))
  end

  def test_should_destroy_serveroperationsystem
    assert_difference('Serveroperationsystem.count', -1) do
      delete :destroy, :id => serveroperationsystems(:one).id
    end

    assert_redirected_to serveroperationsystems_path
  end
end
