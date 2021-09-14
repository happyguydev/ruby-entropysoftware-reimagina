require 'test_helper'

class AxisProgramsControllerTest < ActionController::TestCase
  setup do
    @axis_program = axis_programs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:axis_programs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create axis_program" do
    assert_difference('AxisProgram.count') do
      post :create, axis_program: { assignature_id: @axis_program.assignature_id, descripcion: @axis_program.descripcion, nombre: @axis_program.nombre }
    end

    assert_redirected_to axis_program_path(assigns(:axis_program))
  end

  test "should show axis_program" do
    get :show, id: @axis_program
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @axis_program
    assert_response :success
  end

  test "should update axis_program" do
    patch :update, id: @axis_program, axis_program: { assignature_id: @axis_program.assignature_id, descripcion: @axis_program.descripcion, nombre: @axis_program.nombre }
    assert_redirected_to axis_program_path(assigns(:axis_program))
  end

  test "should destroy axis_program" do
    assert_difference('AxisProgram.count', -1) do
      delete :destroy, id: @axis_program
    end

    assert_redirected_to axis_programs_path
  end
end
