require 'test_helper'

class FeedFormsControllerTest < ActionController::TestCase
  setup do
    @feed_form = feed_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feed_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feed_form" do
    assert_difference('FeedForm.count') do
      post :create, feed_form: { feed_item_id: @feed_form.feed_item_id, feed_score_id: @feed_form.feed_score_id, feedback_id: @feed_form.feedback_id }
    end

    assert_redirected_to feed_form_path(assigns(:feed_form))
  end

  test "should show feed_form" do
    get :show, id: @feed_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feed_form
    assert_response :success
  end

  test "should update feed_form" do
    patch :update, id: @feed_form, feed_form: { feed_item_id: @feed_form.feed_item_id, feed_score_id: @feed_form.feed_score_id, feedback_id: @feed_form.feedback_id }
    assert_redirected_to feed_form_path(assigns(:feed_form))
  end

  test "should destroy feed_form" do
    assert_difference('FeedForm.count', -1) do
      delete :destroy, id: @feed_form
    end

    assert_redirected_to feed_forms_path
  end
end
