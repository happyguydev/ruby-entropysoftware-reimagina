require 'test_helper'

class FactStatusTypesControllerTest < ActionController::TestCase
  setup do
    @fact_status_type = fact_status_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fact_status_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fact_status_type" do
    assert_difference('FactStatusType.count') do
      post :create, fact_status_type: { nombre: @fact_status_type.nombre }
    end

    assert_redirected_to fact_status_type_path(assigns(:fact_status_type))
  end

  test "should show fact_status_type" do
    get :show, id: @fact_status_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fact_status_type
    assert_response :success
  end

  test "should update fact_status_type" do
    patch :update, id: @fact_status_type, fact_status_type: { nombre: @fact_status_type.nombre }
    assert_redirected_to fact_status_type_path(assigns(:fact_status_type))
  end

  test "should destroy fact_status_type" do
    assert_difference('FactStatusType.count', -1) do
      delete :destroy, id: @fact_status_type
    end

    assert_redirected_to fact_status_types_path
  end
end
