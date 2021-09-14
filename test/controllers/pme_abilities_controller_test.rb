require 'test_helper'

class PmeAbilitiesControllerTest < ActionController::TestCase
  setup do
    @pme_ability = pme_abilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pme_abilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pme_ability" do
    assert_difference('PmeAbility.count') do
      post :create, pme_ability: { descripcion: @pme_ability.descripcion, nombre: @pme_ability.nombre }
    end

    assert_redirected_to pme_ability_path(assigns(:pme_ability))
  end

  test "should show pme_ability" do
    get :show, id: @pme_ability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pme_ability
    assert_response :success
  end

  test "should update pme_ability" do
    patch :update, id: @pme_ability, pme_ability: { descripcion: @pme_ability.descripcion, nombre: @pme_ability.nombre }
    assert_redirected_to pme_ability_path(assigns(:pme_ability))
  end

  test "should destroy pme_ability" do
    assert_difference('PmeAbility.count', -1) do
      delete :destroy, id: @pme_ability
    end

    assert_redirected_to pme_abilities_path
  end
end
