class GradesController < ApplicationController
  load_and_authorize_resource

  before_action :set_grade, only: [:show, :edit, :update, :destroy]
  before_action :set_school
  before_action :set_admin_menu

  # GET /grades
  # GET /grades.json
  def index
    @grades = @school.grades
    respond_to do |format|
      format.html
      format.json { render json: GradeDatatable.new(view_context, school_id: @school.id) }
    end
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
    @grade.school = @school
    @student = Student.new
  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)
    @grade.school = @school
    respond_to do |format|
      if @grade.save
        format.html { redirect_to @school, notice: 'Curso creado con éxito.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to @school, notice: 'Curso actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to @school, notice: 'Curso borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_grade
    @grade = Grade.find(params[:id])
  end

  def set_school
    @school = School.find(params[:school_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def grade_params
    params.require(:grade).permit(:school_id, :grado, :letra, :year, :level_id)
  end

  def set_admin_menu
    if current_user.has_school_client_role?
      @school_client_menu = true
    else
      @admin_menu = true
    end
  end
end
