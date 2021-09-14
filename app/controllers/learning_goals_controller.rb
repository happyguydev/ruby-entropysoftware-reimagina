class LearningGoalsController < ApplicationController
  load_and_authorize_resource

  before_action :set_learning_goal, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  # GET /learning_goals
  # GET /learning_goals.json
  def index
    @learning_goals = LearningGoal.all
    @learning_goal = LearningGoal.new
    respond_to do |format|
      format.html
      format.json { render json: LearningGoalDatatable.new(view_context) }
    end
  end
  def macrotabla
      macrotabla = []
      macrotabla_partial = []
      header = ["OA - AE - OF","DESCRIPCION","UNIDAD","NIVEL","ASIGNATURA"];
      macrotabla.push(header);

      LearningGoalsUnit.all.includes(:learning_goal,:unit).each do |q| 
        macrotabla_partial.push(q.try(:learning_goal).try(:nombre) || "NINGUNO")
        macrotabla_partial.push(q.description || "NINGUNO")
        macrotabla_partial.push(q.try(:unit).try(:numero) || "NINGUNO")
        macrotabla_partial.push(q.try(:learning_goal).try(:level).try(:short_name) || "NINGUNO")
        macrotabla_partial.push(q.try(:learning_goal).try(:assignature).try(:short_name) || "NINGUNO")
        macrotabla.push(macrotabla_partial);
        macrotabla_partial = [];
      end 
      @macrotabla = macrotabla
  end

def macrotabla_submit
    #destruyo todas las relaciones entre learning_goal y unit con sus descripciones para crearlas de nuevo
    #extraigo parametros del formulario
    learning_goals = []
    @data = JSON.parse(params[:form_data])    
    respond_to do |format|
    #itero filas de la macrotabla
    macrotabla_params.each do |adv|
        level = Level.where('lower(short_name) = ?', adv[:level].try(:mb_chars).try(:downcase).try(:to_s)).first
         assignature = Assignature.where('lower(short_name) = ?', adv[:assignature].try(:mb_chars).try(:downcase).try(:to_s)).first
         learning_goal = LearningGoal.where(:nombre => adv[:oa_numero],:assignature_id => assignature.try(:id),:level_id => level.try(:id)).first_or_create
         learning_goals.push(learning_goal.id)
    end
    #vacío sólo las unidades de las OA agregadas
    LearningGoalsUnit.where(learning_goal_id: learning_goals).delete_all

    #con las unidades limpias ahora agrego de nuevo las de la macrotabla
    macrotabla_params.each do |adv|
         level = Level.where('lower(short_name) = ?', adv[:level].try(:mb_chars).try(:downcase).try(:to_s)).first
         assignature = Assignature.where('lower(short_name) = ?', adv[:assignature].try(:mb_chars).try(:downcase).try(:to_s)).first
         learning_goal = LearningGoal.where(:nombre => adv[:oa_numero],:assignature_id => assignature.try(:id),:level_id => level.try(:id)).first_or_create
         learning_goals.push(learning_goal)
        if assignature.present? && level.present?
            #separar unidades del campo unidades i.e "1-2-3" = ["1","2","3"]
            units = adv[:units].try(:mb_chars).try(:downcase).try(:to_s).split(/[-\\,y]/).collect{|x| x.strip || x }
            #validar learning_goals de macrotabla
            units.each do |unit|
                unidad = Unit.where(:assignature => assignature, :level => level, :numero => unit).first_or_create
                unidad.learning_goals_units.create(:learning_goal => learning_goal,:description => adv[:oa_descripcion].try(:mb_chars).try(:downcase).try(:to_s))
            end
            #borrar unidades sin objetivo de aprendizaje, podria traer problemas a futuro si se ocupan
            #unidades como entidades independientes (records asociados), lo bueno es que limpia las unidades huerfanas
            #Unit.includes(:learning_goals).where(learning_goals: {id: nil}).destroy_all

          end
        end
        format.js {render inline: "window.location = '/learning_goals/macrotabla'"}
      end
end

  # GET /learning_goals/1
  # GET /learning_goals/1.json
  def show
  end

  # GET /learning_goals/new
  def new
    @learning_goal = LearningGoal.new

  end

  # GET /learning_goals/1/edit
  def edit
    asignatura = @learning_goal.assignature
    nivel = @learning_goal.level
    @unidades = Unit.where(:assignature => asignatura).where(:level => nivel)
  end

  # POST /learning_goals
  # POST /learning_goals.json
  def create
    @learning_goal = LearningGoal.new(learning_goal_params)

    respond_to do |format|
      if @learning_goal.save
        format.html { redirect_to learning_goals_path, notice: 'OA creado con éxito.' }
        format.json { render :show, status: :created, location: @learning_goal }
      else
        format.html { render :new }
        format.json { render json: @learning_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learning_goals/1
  # PATCH/PUT /learning_goals/1.json
  def update
    respond_to do |format|
      if @learning_goal.update(learning_goal_params)
        format.html { redirect_to learning_goals_url, notice: 'OA actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @learning_goal }
      else
        format.html { render :edit }
        format.json { render json: @learning_goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_goals/1
  # DELETE /learning_goals/1.json
  def destroy
    @learning_goal.destroy
    respond_to do |format|
      format.html { redirect_to learning_goals_url, notice: 'OA borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  def get_units
    @units = Unit.where(assignature_id: params[:assignature], level_id: params[:nivel]).collect{|unit| [unit.numero,unit.id]}
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_learning_goal
    @learning_goal = LearningGoal.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def learning_goal_params
    params.require(:learning_goal).permit(:nombre,:assignature_id, :level_id,learning_goals_units_attributes: [:id,:learning_goal_id ,:description,:unit_id,:_destroy])
  end

  def macrotabla_params
      data = JSON.parse(params[:form_data])['mass_macrotabla']
      #Transform data to be student params. For ex:
      data.reject { |s| s[1] == "DESCRIPCION" }.map{|info|
      {
        #params to create massive question to evaluation
        :oa_numero => info[0],
        :oa_descripcion => info[1],
        :units => info[2],
        :level => info[3],
        :assignature => info[4],
        }
      }.select{|attrs| attrs[:oa_numero].present?}
  end

  def set_admin_menu
    @admin_menu = true
  end
end
