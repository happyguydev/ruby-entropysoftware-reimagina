require 'test_helper'

class AxesControllerTest < ActionController::TestCase
  setup do
    @axis = axes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:axes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create axis" do
    assert_difference('Axis.count') do
      post :create, axis: { descripcion: @axis.descripcion, nombre: @axis.nombre }
    end

    assert_redirected_to axis_path(assigns(:axis))
  end

  test "should show axis" do
    get :show, id: @axis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @axis
    assert_response :success
  end

  test "should update axis" do
    patch :update, id: @axis, axis: { descripcion: @axis.descripcion, nombre: @axis.nombre }
    assert_redirected_to axis_path(assigns(:axis))
  end

  test "should destroy axis" do
    assert_difference('Axis.count', -1) do
      delete :destroy, id: @axis
    end

    assert_redirected_to axes_path
  end
end
