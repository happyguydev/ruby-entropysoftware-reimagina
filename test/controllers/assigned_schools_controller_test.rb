require 'test_helper'

class AssignedSchoolsControllerTest < ActionController::TestCase
  setup do
    @assigned_school = assigned_schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assigned_schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assigned_school" do
    assert_difference('AssignedSchool.count') do
      post :create, assigned_school: {  }
    end

    assert_redirected_to assigned_school_path(assigns(:assigned_school))
  end

  test "should show assigned_school" do
    get :show, id: @assigned_school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assigned_school
    assert_response :success
  end

  test "should update assigned_school" do
    patch :update, id: @assigned_school, assigned_school: {  }
    assert_redirected_to assigned_school_path(assigns(:assigned_school))
  end

  test "should destroy assigned_school" do
    assert_difference('AssignedSchool.count', -1) do
      delete :destroy, id: @assigned_school
    end

    assert_redirected_to assigned_schools_path
  end
end
