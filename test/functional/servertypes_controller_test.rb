require 'test_helper'

class ServertypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:servertypes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_servertype
    assert_difference('Servertyp.count') do
      post :create, :servertype => { }
    end

    assert_redirected_to servertype_path(assigns(:servertyp))
  end

  def test_should_show_servertype
    get :show, :id => servertypes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => servertypes(:one).id
    assert_response :success
  end

  def test_should_update_servertype
    put :update, :id => servertypes(:one).id, :servertyp => { }
    assert_redirected_to servertype_path(assigns(:servertyp))
  end

  def test_should_destroy_servertype
    assert_difference('Servertyp.count', -1) do
      delete :destroy, :id => servertypes(:one).id
    end

    assert_redirected_to servertypes_path
  end
end
