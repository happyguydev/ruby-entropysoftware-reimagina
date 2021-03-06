require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get schools" do
    get :schools
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get roles" do
    get :roles
    assert_response :success
  end

end
