require 'test_helper'

class AbilityContentsControllerTest < ActionController::TestCase
  setup do
    @ability_content = ability_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ability_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ability_content" do
    assert_difference('AbilityContent.count') do
      post :create, ability_content: { descripcion: @ability_content.descripcion, nombre: @ability_content.nombre, pme_ability_id: @ability_content.pme_ability_id }
    end

    assert_redirected_to ability_content_path(assigns(:ability_content))
  end

  test "should show ability_content" do
    get :show, id: @ability_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ability_content
    assert_response :success
  end

  test "should update ability_content" do
    patch :update, id: @ability_content, ability_content: { descripcion: @ability_content.descripcion, nombre: @ability_content.nombre, pme_ability_id: @ability_content.pme_ability_id }
    assert_redirected_to ability_content_path(assigns(:ability_content))
  end

  test "should destroy ability_content" do
    assert_difference('AbilityContent.count', -1) do
      delete :destroy, id: @ability_content
    end

    assert_redirected_to ability_contents_path
  end
end
