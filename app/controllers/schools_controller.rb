class SchoolsController < ApplicationController
  load_and_authorize_resource

  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all
    respond_to do |format|
      format.html
      format.json { render json: SchoolDatatable.new(view_context) }
    end
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @grade = Grade.new
    @school_users = User.joins(:assigned_schools).where("assigned_schools.school_id = #{@school.id}")
  end

  # GET /schools/new
  def new
    @school = School.new
    @school.users.build
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'Establecimiento creado con éxito.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'Establecimiento actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'Establecimiento borrado con éxito.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:nombre, :rut, :socialmean, :direccion, :email,:logo, :telefono, :info_contacto,:rbd, :dependencia,:commune_id, users_attributes: [:id, :first_name,:second_name,:email, :password,:tel,:user_type_id,:_destroy])
    end

    def set_admin_menu
      if current_user.has_school_client_role?
        @school_client_menu = true
      else
        @admin_menu = true
      end
    end
end
