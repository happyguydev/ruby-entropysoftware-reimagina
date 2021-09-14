require 'test_helper'

class ProcTypesControllerTest < ActionController::TestCase
  setup do
    @proc_type = proc_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proc_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proc_type" do
    assert_difference('ProcType.count') do
      post :create, proc_type: { descripcion: @proc_type.descripcion, nombre: @proc_type.nombre }
    end

    assert_redirected_to proc_type_path(assigns(:proc_type))
  end

  test "should show proc_type" do
    get :show, id: @proc_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proc_type
    assert_response :success
  end

  test "should update proc_type" do
    patch :update, id: @proc_type, proc_type: { descripcion: @proc_type.descripcion, nombre: @proc_type.nombre }
    assert_redirected_to proc_type_path(assigns(:proc_type))
  end

  test "should destroy proc_type" do
    assert_difference('ProcType.count', -1) do
      delete :destroy, id: @proc_type
    end

    assert_redirected_to proc_types_path
  end
end
