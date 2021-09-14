require 'test_helper'

class FeedScoresControllerTest < ActionController::TestCase
  setup do
    @feed_score = feed_scores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feed_scores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feed_score" do
    assert_difference('FeedScore.count') do
      post :create, feed_score: { nombre: @feed_score.nombre, score: @feed_score.score }
    end

    assert_redirected_to feed_score_path(assigns(:feed_score))
  end

  test "should show feed_score" do
    get :show, id: @feed_score
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feed_score
    assert_response :success
  end

  test "should update feed_score" do
    patch :update, id: @feed_score, feed_score: { nombre: @feed_score.nombre, score: @feed_score.score }
    assert_redirected_to feed_score_path(assigns(:feed_score))
  end

  test "should destroy feed_score" do
    assert_difference('FeedScore.count', -1) do
      delete :destroy, id: @feed_score
    end

    assert_redirected_to feed_scores_path
  end
end
