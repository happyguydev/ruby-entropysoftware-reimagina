require 'test_helper'

class BuyOrdersControllerTest < ActionController::TestCase
  setup do
    @buy_order = buy_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buy_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buy_order" do
    assert_difference('BuyOrder.count') do
      post :create, buy_order: { comentario: @buy_order.comentario, fecha: @buy_order.fecha, monto: @buy_order.monto, num_licitacion: @buy_order.num_licitacion, numero: @buy_order.numero, order_id: @buy_order.order_id }
    end

    assert_redirected_to buy_order_path(assigns(:buy_order))
  end

  test "should show buy_order" do
    get :show, id: @buy_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buy_order
    assert_response :success
  end

  test "should update buy_order" do
    patch :update, id: @buy_order, buy_order: { comentario: @buy_order.comentario, fecha: @buy_order.fecha, monto: @buy_order.monto, num_licitacion: @buy_order.num_licitacion, numero: @buy_order.numero, order_id: @buy_order.order_id }
    assert_redirected_to buy_order_path(assigns(:buy_order))
  end

  test "should destroy buy_order" do
    assert_difference('BuyOrder.count', -1) do
      delete :destroy, id: @buy_order
    end

    assert_redirected_to buy_orders_path
  end
end
