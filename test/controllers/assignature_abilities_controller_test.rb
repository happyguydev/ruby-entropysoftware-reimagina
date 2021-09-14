require 'test_helper'

class AssignatureAbilitiesControllerTest < ActionController::TestCase
  setup do
    @assignature_ability = assignature_abilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignature_abilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignature_ability" do
    assert_difference('AssignatureAbility.count') do
      post :create, assignature_ability: { descripcion: @assignature_ability.descripcion, nombre: @assignature_ability.nombre }
    end

    assert_redirected_to assignature_ability_path(assigns(:assignature_ability))
  end

  test "should show assignature_ability" do
    get :show, id: @assignature_ability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assignature_ability
    assert_response :success
  end

  test "should update assignature_ability" do
    patch :update, id: @assignature_ability, assignature_ability: { descripcion: @assignature_ability.descripcion, nombre: @assignature_ability.nombre }
    assert_redirected_to assignature_ability_path(assigns(:assignature_ability))
  end

  test "should destroy assignature_ability" do
    assert_difference('AssignatureAbility.count', -1) do
      delete :destroy, id: @assignature_ability
    end

    assert_redirected_to assignature_abilities_path
  end
end
