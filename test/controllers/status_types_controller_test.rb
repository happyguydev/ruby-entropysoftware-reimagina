require 'test_helper'

class StatusTypesControllerTest < ActionController::TestCase
  setup do
    @status_type = status_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_type" do
    assert_difference('StatusType.count') do
      post :create, status_type: { descripcion: @status_type.descripcion, nombre: @status_type.nombre }
    end

    assert_redirected_to status_type_path(assigns(:status_type))
  end

  test "should show status_type" do
    get :show, id: @status_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @status_type
    assert_response :success
  end

  test "should update status_type" do
    patch :update, id: @status_type, status_type: { descripcion: @status_type.descripcion, nombre: @status_type.nombre }
    assert_redirected_to status_type_path(assigns(:status_type))
  end

  test "should destroy status_type" do
    assert_difference('StatusType.count', -1) do
      delete :destroy, id: @status_type
    end

    assert_redirected_to status_types_path
  end
end
