require 'test_helper'

class DifficultyLevelsControllerTest < ActionController::TestCase
  setup do
    @difficulty_level = difficulty_levels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:difficulty_levels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create difficulty_level" do
    assert_difference('DifficultyLevel.count') do
      post :create, difficulty_level: { name: @difficulty_level.name }
    end

    assert_redirected_to difficulty_level_path(assigns(:difficulty_level))
  end

  test "should show difficulty_level" do
    get :show, id: @difficulty_level
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @difficulty_level
    assert_response :success
  end

  test "should update difficulty_level" do
    patch :update, id: @difficulty_level, difficulty_level: { name: @difficulty_level.name }
    assert_redirected_to difficulty_level_path(assigns(:difficulty_level))
  end

  test "should destroy difficulty_level" do
    assert_difference('DifficultyLevel.count', -1) do
      delete :destroy, id: @difficulty_level
    end

    assert_redirected_to difficulty_levels_path
  end
end
