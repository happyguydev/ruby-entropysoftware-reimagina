require 'test_helper'

class BloomAbilitiesControllerTest < ActionController::TestCase
  setup do
    @bloom_ability = bloom_abilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bloom_abilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bloom_ability" do
    assert_difference('BloomAbility.count') do
      post :create, bloom_ability: { descripcion: @bloom_ability.descripcion, nombre: @bloom_ability.nombre }
    end

    assert_redirected_to bloom_ability_path(assigns(:bloom_ability))
  end

  test "should show bloom_ability" do
    get :show, id: @bloom_ability
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bloom_ability
    assert_response :success
  end

  test "should update bloom_ability" do
    patch :update, id: @bloom_ability, bloom_ability: { descripcion: @bloom_ability.descripcion, nombre: @bloom_ability.nombre }
    assert_redirected_to bloom_ability_path(assigns(:bloom_ability))
  end

  test "should destroy bloom_ability" do
    assert_difference('BloomAbility.count', -1) do
      delete :destroy, id: @bloom_ability
    end

    assert_redirected_to bloom_abilities_path
  end
end
