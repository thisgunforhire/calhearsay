require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_tags
    assert_difference('Tags.count') do
      post :create, :tags => { }
    end

    assert_redirected_to tags_path(assigns(:tags))
  end

  def test_should_show_tags
    get :show, :id => tags(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tags(:one).id
    assert_response :success
  end

  def test_should_update_tags
    put :update, :id => tags(:one).id, :tags => { }
    assert_redirected_to tags_path(assigns(:tags))
  end

  def test_should_destroy_tags
    assert_difference('Tags.count', -1) do
      delete :destroy, :id => tags(:one).id
    end

    assert_redirected_to tags_path
  end
end
