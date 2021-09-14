require 'test_helper'

class GroupQuestionsControllerTest < ActionController::TestCase
  setup do
    @group_question = group_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_question" do
    assert_difference('GroupQuestion.count') do
      post :create, group_question: { statement: @group_question.statement }
    end

    assert_redirected_to group_question_path(assigns(:group_question))
  end

  test "should show group_question" do
    get :show, id: @group_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_question
    assert_response :success
  end

  test "should update group_question" do
    patch :update, id: @group_question, group_question: { statement: @group_question.statement }
    assert_redirected_to group_question_path(assigns(:group_question))
  end

  test "should destroy group_question" do
    assert_difference('GroupQuestion.count', -1) do
      delete :destroy, id: @group_question
    end

    assert_redirected_to group_questions_path
  end
end
