class AdvicesController < ApplicationController
  before_action :set_advice, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu

  # GET /advices
  # GET /advices.json
  def index
    @advices = Advice.all
    @advice = Advice.new

    respond_to do |format|
      format.html
      format.json { render json: AdviceDatatable.new(view_context) }
    end
  end

  # GET /advices/1
  # GET /advices/1.json
  def show
  end

  # GET /advices/new
  def new
    @advice = Advice.new
  end

  # GET /advices/1/edit
  def edit
  end

  # POST /advices
  # POST /advices.json
  def create
    @advice = Advice.new(advice_params)

    respond_to do |format|
      if @advice.save
        format.html { redirect_to  advices_url, notice: 'Remedial agregado con éxito' }
        format.json { render :show, status: :created, location: @advice }
      else
        format.html { render :new }
        format.json { render json: @advice.errors, status: :unprocessable_entity }
      end
    end
  end

    def mass_remedials
    @data = JSON.parse(params[:form_data])
    instrument = Instrument.find(@data['instrument'])
    assignature = instrument.evaluation.assignature
    respond_to do |format|
      mass_advice_params.each do |adv|
         level = Level.where('lower(short_name) = ?', adv[:level].try(:mb_chars).try(:downcase).try(:to_s)).first
         question = Question.find(adv[:question_id])
         alt = "abcdefghijklmnopq"             
         #changing guide
         if adv[:alternative_index].present? && (adv[:alternative_index].downcase.strip.in? alt) && (adv[:alternative_index].length == 1)            
          guide = Guide.where(instrument: instrument).where(question: question).first
          guide.alternative_index = adv[:alternative_index].try(:mb_chars).try(:upcase).try(:to_s).strip
          guide.save 
         end

         question.content = Content.where('lower(nombre) = ? AND assignature_id = ? ', adv[:content].try(:mb_chars).try(:downcase).try(:to_s), assignature.id).first_or_create(:nombre=> adv[:content], :assignature_id => assignature.id)
         question.difficulty_level = DifficultyLevel.where('lower(name) = ?', adv[:difficulty_level].try(:mb_chars).try(:downcase).try(:to_s)).first_or_create(:name=> adv[:difficulty_level])
         question.axis_program = AxisProgram.where('lower(nombre) = ? AND assignature_id = ? ', adv[:axis_program].try(:mb_chars).try(:downcase).try(:to_s), assignature.id).first_or_create(:nombre => adv[:axis_program], :assignature_id => assignature.id)
         question.axis = Axis.where('lower(nombre) = ? AND assignature_id = ? ', adv[:axis].try(:mb_chars).try(:downcase).try(:to_s), assignature.id).first_or_create(:nombre => adv[:axis], :assignature_id => assignature.id)
         question.bloom_ability = BloomAbility.where('lower(nombre) = ?', adv[:bloom_ability].try(:mb_chars).try(:downcase).try(:to_s)).first_or_create(:nombre => adv[:bloom_ability])
         question.advice = Advice.where('lower(name) = ?', adv[:remedial].try(:mb_chars).try(:downcase).try(:to_s)).first_or_create(:name=> adv[:remedial])
         question.pme_ability = PmeAbility.where('lower(nombre) = ? AND assignature_id =? ', adv[:pme_ability].try(:mb_chars).try(:downcase).try(:to_s), assignature.id).first_or_create(:nombre => adv[:pme_ability], :assignature_id => assignature.id)
         question.assignature_ability = AssignatureAbility.where('lower(nombre) = ? AND assignature_id = ?', adv[:assignature_ability].try(:mb_chars).try(:downcase).try(:to_s), assignature.id).first_or_create(:nombre => adv[:assignature_ability], :assignature_id => assignature.id)
         question.level = level
         #destruyo learning goals para el caso donde le quito learning_goals
         question.learning_goals.destroy_all
         question.units.destroy_all

          #separate learning_goals from column
          learning_goals = adv[:learning_goal_number].try(:mb_chars).try(:downcase).try(:to_s).split(/[-\\,y]/).collect{|x| x.strip || x }
          units = adv[:unit].try(:mb_chars).try(:downcase).try(:to_s).split(/[-\\,y]/).collect{|x| x.strip || x }
          learning_goals_array = []
          units_array = []

          #validates learning_goals from macrotabla
            if learning_goals != nil
            learning_goals.each do |lg|
              learning_goal = LearningGoal.where('lower(nombre) = ? AND assignature_id = ? AND level_id = ?', lg, assignature.id, level.id).first
              #if question hasnt that learning goal assigned, assign
              if learning_goal.present?
                learning_goals_array.push(learning_goal)
              if units != nil 
               units.each do |unit|
                 unit = Unit.where('lower(numero) = ? AND assignature_id = ? AND level_id = ?', unit, assignature.id, level.id).first
                  #if unit hasnt that learning goal assigned, assign
                  #validar que el objetivo de aprendizaje existe
                   if learning_goals_array.first.try(:units).exists?(unit.try(:id))
                     units_array.push(unit)
                   end
               end
             end
                end
              end

  
            end
            question.learning_goals.push(learning_goals_array.uniq)
            question.units.push(units_array.uniq)
            question.save

      end
      #Elimino especificaciones que quedaron sin pregunta asociada
        Content.includes(:questions).where(questions: {id: nil}).destroy_all
        Advice.includes(:questions).where(questions: {id: nil}).destroy_all
        DifficultyLevel.includes(:questions).where(questions: {id: nil}).destroy_all
        AxisProgram.includes(:questions).where(questions: {id: nil}).destroy_all
        Axis.includes(:questions).where(questions: {id: nil}).destroy_all
        PmeAbility.includes(:questions).where(questions: {id: nil}).destroy_all
        AssignatureAbility.includes(:questions).where(questions: {id: nil}).destroy_all

        format.js {render inline: "window.location = '/instruments'"}
    end
  end

  # PATCH/PUT /advices/1
  # PATCH/PUT /advices/1.json
  def update
    respond_to do |format|
      if @advice.update(advice_params)
        format.html { redirect_to  advices_url, notice: 'Remedial actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @advice }
      else
        format.html { render :edit }
        format.json { render json: @advice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advices/1
  # DELETE /advices/1.json
  def destroy
    @advice.destroy
    respond_to do |format|
      format.html { redirect_to advices_url, notice: 'Remedial borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice
      @advice = Advice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advice_params
      params.require(:advice).permit(:name)
    end

    def mass_advice_params
      data = JSON.parse(params[:form_data])['mass_remedials']
      #Transform data to be student params. For ex:
      data.reject { |s| s[0] == "ID" }.map{|info|
      {
        #params to create massive question to evaluation
        :question_id => info[0],
        :question_index => info[1],
        :alternative_index => info[2],
        :content => info[3].try(:squish),
        :axis_program => info[4].try(:squish),
        :axis => info[5].try(:squish),
        :pme_ability => info[6].try(:squish),
        :learning_goal => info[7],
        :learning_goal_number => info[8],
        :level => info[9],
        :unit => info[10],
        :assignature_ability => info[11].try(:squish),
        :bloom_ability => info[12].try(:squish),
        :difficulty_level => info[13].try(:squish),
        :remedial => info[14].try(:squish)
        }
      }.select{|attrs| attrs[:question_id].present?}
    end

  def set_admin_menu
    @admin_menu = true
  end
end
