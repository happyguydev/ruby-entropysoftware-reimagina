require 'test_helper'

class AxesContentsControllerTest < ActionController::TestCase
  setup do
    @axes_content = axes_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:axes_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create axes_content" do
    assert_difference('AxesContent.count') do
      post :create, axes_content: { axis_id: @axes_content.axis_id, descripcion: @axes_content.descripcion, nombre: @axes_content.nombre }
    end

    assert_redirected_to axes_content_path(assigns(:axes_content))
  end

  test "should show axes_content" do
    get :show, id: @axes_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @axes_content
    assert_response :success
  end

  test "should update axes_content" do
    patch :update, id: @axes_content, axes_content: { axis_id: @axes_content.axis_id, descripcion: @axes_content.descripcion, nombre: @axes_content.nombre }
    assert_redirected_to axes_content_path(assigns(:axes_content))
  end

  test "should destroy axes_content" do
    assert_difference('AxesContent.count', -1) do
      delete :destroy, id: @axes_content
    end

    assert_redirected_to axes_contents_path
  end
end
