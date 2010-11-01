require File.dirname(__FILE__) + '/../test_helper'

class LogrowsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:logrows)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_logrow
    assert_difference('Logrow.count') do
      post :create, :logrow => { }
    end

    assert_redirected_to logrow_path(assigns(:logrow))
  end

  def test_should_show_logrow
    get :show, :id => logrows(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => logrows(:one).id
    assert_response :success
  end

  def test_should_update_logrow
    put :update, :id => logrows(:one).id, :logrow => { }
    assert_redirected_to logrow_path(assigns(:logrow))
  end

  def test_should_destroy_logrow
    assert_difference('Logrow.count', -1) do
      delete :destroy, :id => logrows(:one).id
    end

    assert_redirected_to logrows_path
  end
end
