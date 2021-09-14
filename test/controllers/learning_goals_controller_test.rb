require 'test_helper'

class LearningGoalsControllerTest < ActionController::TestCase
  setup do
    @learning_goal = learning_goals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:learning_goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create learning_goal" do
    assert_difference('LearningGoal.count') do
      post :create, learning_goal: { assignature_id: @learning_goal.assignature_id, descripcion: @learning_goal.descripcion, level_id: @learning_goal.level_id, nombre: @learning_goal.nombre }
    end

    assert_redirected_to learning_goal_path(assigns(:learning_goal))
  end

  test "should show learning_goal" do
    get :show, id: @learning_goal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @learning_goal
    assert_response :success
  end

  test "should update learning_goal" do
    patch :update, id: @learning_goal, learning_goal: { assignature_id: @learning_goal.assignature_id, descripcion: @learning_goal.descripcion, level_id: @learning_goal.level_id, nombre: @learning_goal.nombre }
    assert_redirected_to learning_goal_path(assigns(:learning_goal))
  end

  test "should destroy learning_goal" do
    assert_difference('LearningGoal.count', -1) do
      delete :destroy, id: @learning_goal
    end

    assert_redirected_to learning_goals_path
  end
end
