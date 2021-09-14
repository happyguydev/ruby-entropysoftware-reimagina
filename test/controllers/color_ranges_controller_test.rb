require 'test_helper'

class ColorRangesControllerTest < ActionController::TestCase
  setup do
    @color_range = color_ranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:color_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create color_range" do
    assert_difference('ColorRange.count') do
      post :create, color_range: { color: @color_range.color, evaluation_type_id: @color_range.evaluation_type_id, max: @color_range.max, min: @color_range.min, nombre: @color_range.nombre, simce_range: @color_range.simce_range }
    end

    assert_redirected_to color_range_path(assigns(:color_range))
  end

  test "should show color_range" do
    get :show, id: @color_range
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @color_range
    assert_response :success
  end

  test "should update color_range" do
    patch :update, id: @color_range, color_range: { color: @color_range.color, evaluation_type_id: @color_range.evaluation_type_id, max: @color_range.max, min: @color_range.min, nombre: @color_range.nombre, simce_range: @color_range.simce_range }
    assert_redirected_to color_range_path(assigns(:color_range))
  end

  test "should destroy color_range" do
    assert_difference('ColorRange.count', -1) do
      delete :destroy, id: @color_range
    end

    assert_redirected_to color_ranges_path
  end
end
