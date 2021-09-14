require 'test_helper'

class RemedialsControllerTest < ActionController::TestCase
  setup do
    @remedial = remedials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remedials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remedial" do
    assert_difference('Remedial.count') do
      post :create, remedial: { content_id: @remedial.content_id, level_id: @remedial.level_id, nombre: @remedial.nombre }
    end

    assert_redirected_to remedial_path(assigns(:remedial))
  end

  test "should show remedial" do
    get :show, id: @remedial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @remedial
    assert_response :success
  end

  test "should update remedial" do
    patch :update, id: @remedial, remedial: { content_id: @remedial.content_id, level_id: @remedial.level_id, nombre: @remedial.nombre }
    assert_redirected_to remedial_path(assigns(:remedial))
  end

  test "should destroy remedial" do
    assert_difference('Remedial.count', -1) do
      delete :destroy, id: @remedial
    end

    assert_redirected_to remedials_path
  end
end
