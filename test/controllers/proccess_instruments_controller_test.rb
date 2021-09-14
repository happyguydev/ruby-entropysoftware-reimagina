require 'test_helper'

class ProccessInstrumentsControllerTest < ActionController::TestCase
  setup do
    @proccess_instrument = proccess_instruments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proccess_instruments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proccess_instrument" do
    assert_difference('ProccessInstrument.count') do
      post :create, proccess_instrument: { instrument_id: @proccess_instrument.instrument_id, proccess_id: @proccess_instrument.proccess_id }
    end

    assert_redirected_to proccess_instrument_path(assigns(:proccess_instrument))
  end

  test "should show proccess_instrument" do
    get :show, id: @proccess_instrument
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @proccess_instrument
    assert_response :success
  end

  test "should update proccess_instrument" do
    patch :update, id: @proccess_instrument, proccess_instrument: { instrument_id: @proccess_instrument.instrument_id, proccess_id: @proccess_instrument.proccess_id }
    assert_redirected_to proccess_instrument_path(assigns(:proccess_instrument))
  end

  test "should destroy proccess_instrument" do
    assert_difference('ProccessInstrument.count', -1) do
      delete :destroy, id: @proccess_instrument
    end

    assert_redirected_to proccess_instruments_path
  end
end
