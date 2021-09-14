require 'test_helper'

class ProcTypeFathersControllerTest < ActionController::TestCase
  setup do
    @proc_type_father = proc_type_fathers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proc_type_fathers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proc_type_father" do
    assert_difference('ProcTypeFather.count') do
      post :create, proc_type_father: { nombre: @proc_type_father.nombre, short_name: @proc_type_father.short_name }
    end

    assert_redirected_to proc_type_father_path(assigns(:proc_type_father))
  end

  test "should show proc_type_father" do
    get :show, id: @proc_type_father
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proc_type_father
    assert_response :success
  end

  test "should update proc_type_father" do
    patch :update, id: @proc_type_father, proc_type_father: { nombre: @proc_type_father.nombre, short_name: @proc_type_father.short_name }
    assert_redirected_to proc_type_father_path(assigns(:proc_type_father))
  end

  test "should destroy proc_type_father" do
    assert_difference('ProcTypeFather.count', -1) do
      delete :destroy, id: @proc_type_father
    end

    assert_redirected_to proc_type_fathers_path
  end
end
