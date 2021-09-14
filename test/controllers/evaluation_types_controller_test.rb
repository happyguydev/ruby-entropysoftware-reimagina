require 'test_helper'

class EvaluationTypesControllerTest < ActionController::TestCase
  setup do
    @evaluation_type = evaluation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluation_type" do
    assert_difference('EvaluationType.count') do
      post :create, evaluation_type: { descripcion: @evaluation_type.descripcion, nombre: @evaluation_type.nombre }
    end

    assert_redirected_to evaluation_type_path(assigns(:evaluation_type))
  end

  test "should show evaluation_type" do
    get :show, id: @evaluation_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @evaluation_type
    assert_response :success
  end

  test "should update evaluation_type" do
    patch :update, id: @evaluation_type, evaluation_type: { descripcion: @evaluation_type.descripcion, nombre: @evaluation_type.nombre }
    assert_redirected_to evaluation_type_path(assigns(:evaluation_type))
  end

  test "should destroy evaluation_type" do
    assert_difference('EvaluationType.count', -1) do
      delete :destroy, id: @evaluation_type
    end

    assert_redirected_to evaluation_types_path
  end
end
