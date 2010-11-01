require File.dirname(__FILE__) + '/../test_helper'

class UserlogbooksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:userlogbooks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_userlogbook
    assert_difference('Userlogbook.count') do
      post :create, :userlogbook => { }
    end

    assert_redirected_to userlogbook_path(assigns(:userlogbook))
  end

  def test_should_show_userlogbook
    get :show, :id => userlogbooks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => userlogbooks(:one).id
    assert_response :success
  end

  def test_should_update_userlogbook
    put :update, :id => userlogbooks(:one).id, :userlogbook => { }
    assert_redirected_to userlogbook_path(assigns(:userlogbook))
  end

  def test_should_destroy_userlogbook
    assert_difference('Userlogbook.count', -1) do
      delete :destroy, :id => userlogbooks(:one).id
    end

    assert_redirected_to userlogbooks_path
  end
end
