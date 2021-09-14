require 'test_helper'

class FactStatusesControllerTest < ActionController::TestCase
  setup do
    @fact_status = fact_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fact_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fact_status" do
    assert_difference('FactStatus.count') do
      post :create, fact_status: { comentario: @fact_status.comentario, fact_status_type_id: @fact_status.fact_status_type_id, order_id: @fact_status.order_id }
    end

    assert_redirected_to fact_status_path(assigns(:fact_status))
  end

  test "should show fact_status" do
    get :show, id: @fact_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fact_status
    assert_response :success
  end

  test "should update fact_status" do
    patch :update, id: @fact_status, fact_status: { comentario: @fact_status.comentario, fact_status_type_id: @fact_status.fact_status_type_id, order_id: @fact_status.order_id }
    assert_redirected_to fact_status_path(assigns(:fact_status))
  end

  test "should destroy fact_status" do
    assert_difference('FactStatus.count', -1) do
      delete :destroy, id: @fact_status
    end

    assert_redirected_to fact_statuses_path
  end
end
