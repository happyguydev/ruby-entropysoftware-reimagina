class StudentsController < ApplicationController
  load_and_authorize_resource

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_grade, except: [:mass_input]
  before_action :set_admin_menu

  # GET /students
  # GET /students.json
  def index
    @students = @grade.students
    respond_to do |format|
      format.html
      format.json { render json: StudentDatatable.new(view_context, grade_id: @grade.id) }
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student.grade = @grade
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  def mass_input
    @data = JSON.parse(params[:form_data])
    @grade = Grade.find(@data['grade'])
    respond_to do |format|
      mass_student_params.each do |stu|
        tempstu = Student.create_with(stu).find_or_create_by(rut: stu[:rut])
        if @grade.students.where(:rut => tempstu.rut).count == 0
          @grade.students << tempstu
        else
          format.json { render json: {success: true}, status: :unprocessable_entity, error: 'Estudiante ya existe en este curso' }
        end
        format.js {render inline: "location.reload();"}
      end
    end
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.create_with(student_params).find_or_create_by(rut: student_params[:rut])
    if @grade.students.where(:rut => student_params[:rut]).count == 0
      @grade.students << @student
    end
    respond_to do |format|
      if @student.save
        format.html { redirect_to school_grade_path(@grade.school,@grade), notice: 'Alumno creado con éxito.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to school_grade_path(@grade.school,@grade), notice: 'Alumno actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to school_grade_path(@grade.school, @grade), notice: 'Alumno borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  def set_grade
    @grade = Grade.find(params[:grade_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:nombre, :apellido, :rut)
  end

  def mass_student_params
    data = JSON.parse(params[:form_data])['mass_students']
    #Transform data to be student params. For ex:
    data.reject { |s| s[0] == "RUT" }.map{|info| {:rut => info[0], :nombre => info[1], :apellido => info[2]}}.select{|attrs| attrs[:rut].present?}
  end

  def set_admin_menu
    if current_user.has_school_client_role?
      @school_client_menu = true
    else
      @admin_menu = true
    end
  end
end
