require 'test_helper'

class ProccessesControllerTest < ActionController::TestCase
  setup do
    @proccess = proccesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proccesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proccess" do
    assert_difference('Proccess.count') do
      post :create, proccess: { monto: @proccess.monto, nombre: @proccess.nombre, order_id: @proccess.order_id, proc_type_id: @proccess.proc_type_id }
    end

    assert_redirected_to proccess_path(assigns(:proccess))
  end

  test "should show proccess" do
    get :show, id: @proccess
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proccess
    assert_response :success
  end

  test "should update proccess" do
    patch :update, id: @proccess, proccess: { monto: @proccess.monto, nombre: @proccess.nombre, order_id: @proccess.order_id, proc_type_id: @proccess.proc_type_id }
    assert_redirected_to proccess_path(assigns(:proccess))
  end

  test "should destroy proccess" do
    assert_difference('Proccess.count', -1) do
      delete :destroy, id: @proccess
    end

    assert_redirected_to proccesses_path
  end
end
