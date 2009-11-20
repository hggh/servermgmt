require 'test_helper'

class IptypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:iptypes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_iptype
    assert_difference('Iptype.count') do
      post :create, :iptype => { }
    end

    assert_redirected_to iptype_path(assigns(:iptype))
  end

  def test_should_show_iptype
    get :show, :id => iptypes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => iptypes(:one).id
    assert_response :success
  end

  def test_should_update_iptype
    put :update, :id => iptypes(:one).id, :iptype => { }
    assert_redirected_to iptype_path(assigns(:iptype))
  end

  def test_should_destroy_iptype
    assert_difference('Iptype.count', -1) do
      delete :destroy, :id => iptypes(:one).id
    end

    assert_redirected_to iptypes_path
  end
end
