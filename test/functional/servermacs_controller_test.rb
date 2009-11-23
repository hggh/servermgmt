require 'test_helper'

class ServermacsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:servermacs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_servermac
    assert_difference('Servermac.count') do
      post :create, :servermac => { }
    end

    assert_redirected_to servermac_path(assigns(:servermac))
  end

  def test_should_show_servermac
    get :show, :id => servermacs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => servermacs(:one).id
    assert_response :success
  end

  def test_should_update_servermac
    put :update, :id => servermacs(:one).id, :servermac => { }
    assert_redirected_to servermac_path(assigns(:servermac))
  end

  def test_should_destroy_servermac
    assert_difference('Servermac.count', -1) do
      delete :destroy, :id => servermacs(:one).id
    end

    assert_redirected_to servermacs_path
  end
end
