require 'test_helper'

class ServertypsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:servertyps)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_servertyp
    assert_difference('Servertyp.count') do
      post :create, :servertyp => { }
    end

    assert_redirected_to servertyp_path(assigns(:servertyp))
  end

  def test_should_show_servertyp
    get :show, :id => servertyps(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => servertyps(:one).id
    assert_response :success
  end

  def test_should_update_servertyp
    put :update, :id => servertyps(:one).id, :servertyp => { }
    assert_redirected_to servertyp_path(assigns(:servertyp))
  end

  def test_should_destroy_servertyp
    assert_difference('Servertyp.count', -1) do
      delete :destroy, :id => servertyps(:one).id
    end

    assert_redirected_to servertyps_path
  end
end
