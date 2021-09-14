class QuestionsController < ApplicationController
  load_and_authorize_resource

  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  skip_before_action :verify_authenticity_token
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
    respond_to do |format|
      format.html
      format.json { render json: QuestionListDatatable.new(view_context) }
    end
  end

  def add_questions_to_evaluation
    @questions = Question.all
    respond_to do |format|
      format.html
      format.json { render json: QuestionDatatable.new(view_context) }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.alternatives.build
  end

  # GET /questions/1/edit
  def edit
    @question.alternatives.new if @question.alternatives.count == 0
  end

  # POST /questions
  # POST /questions.json
  def create
    logger.info "######### REQUEST REFERER: #{referer_relative_path}"
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        if @question.group_question_id.present? && request.referer.eql?(group_question_url(@question.group_question_id))
          format.html { redirect_to group_question_url(@question.group_question_id), notice: 'Pregunta creada con éxito.' }
        else
          format.html { redirect_to @question, notice: 'Pregunta creada con éxito.' }
          format.json { render :show, status: :created, location: @question }
        end
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)

        format.html { redirect_to @question, notice: 'Pregunta actualizada con éxito.' }

        flash[:notice] = 'Pregunta actualizada con éxito.' if request.xhr? == 0
         format.js# { render 'update', notice: 'Pregunta actualizada con éxito.' }
        # format.json { render :show, status: :ok, location: @question }
      else
        format.js
        format.html { render :edit }
        # format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Pregunta borrada con éxito.' }
      format.json { head :no_content }
    end
  end

  def mass_input

  end
  def mass_evelution_edit
    session[:current_instrument] = Instrument.find(params[:id]).id
    @instrument = Instrument.find(params[:id])
    @evaluation = @instrument.evaluation
    #no sure if this line you wrote will order both questions and alternatives by index
    #questions must be ordered by position (1,2,3,4,5,6...) and alternatives inside by position ("A","B","C"...)
    #@questions_collection = @instrument.instrument_alternatives_positions.order('position ASC').sort.collect(&:question).uniq
    @questions_collection = @instrument.instrument_questions_positions.order('position ASC').collect(&:question).uniq
    #@questions_collection = Instrument.find(@evaluation.instruments.first.id).instrument_alternatives_positions.order('position ASC').collect(&:question).uniq
    # @questions_collection = @instrument.instrument_alternatives_positions.order('position ASC').collect(&:question).uniq
    # @questions_collection = Instrument.where(evaluation_id:@evaluation.id).first.instrument_alternatives_positions.order('position ASC').collect(&:question).uniq
    # @questions_collection = Instrument.where(evaluation_id:@evaluation.id).first.instrument_questions_positions.order('position ASC').collect(&:question)
    @questions_data = {'evaluation_name':  @evaluation.nombre,'evaluation_year':  @evaluation.year}.as_json
    @evalution_type = @evaluation.evaluation_type
    @level = @evaluation.level
    @assignature = @evaluation.assignature
    @group_question = GroupQuestion.new
  end

  def mass_input_create
    # @question = Question.new
    # @question.alternatives.build
    #here we receive data from mass_input_params to create evaluation with this questions
    @questions_data = JSON.parse(params[:form_data])
    @questions_collection = []
    guuide_indexes = []
    #get assignature_id, level_id, evaluation year, name, and type from form_data
    @assignature_id = Assignature.where(:short_name => @questions_data['assignature_id']).first.id
    @level_id = Level.where(:short_name => @questions_data['level_id']).first.id
    @evaluation_name = @questions_data['evaluation_name']
    @evaluation_year = @questions_data['evaluation_year']
    @alternatives_amount = @questions_data['alternatives_amount'].to_i
    @mass_questions_params = mass_questions_params

    @evalution_type = EvaluationType.where(:short_name => @questions_data['evaluation_type']).first
    @assignature = Assignature.where(:short_name => @questions_data['assignature_id']).first
    @level = Level.where(:short_name => @questions_data['level_id']).first
    @group_question = GroupQuestion.new
    array_obj = Array.new
    @mass_questions_params.each_with_index do |sc, index|
      #find or create question attributes (pme_ability,difficulty_level,axis, and so on) case insensitive
            #then create questions and add to a new evaluation
            #validate content with the same name and assignature create if not exist
            content = Content.where('lower(nombre) = ? AND assignature_id = ? ', sc[:content].try(:mb_chars).try(:downcase).try(:to_s), @assignature_id).first_or_create(:nombre=> sc[:content], :assignature_id => @assignature_id)
            #validate difficulty_level , create if not exist
            difficulty_level = DifficultyLevel.where('lower(name) = ?', sc[:difficulty_level].try(:mb_chars).try(:downcase).try(:to_s)).first_or_create(:name=> sc[:difficulty_level])

            #validate axis , create if not exists
            axis = Axis.where('lower(nombre) = ? AND assignature_id = ? ', sc[:axis].try(:mb_chars).try(:downcase).try(:to_s), @assignature_id).first_or_create(:nombre => sc[:axis], :assignature_id => @assignature_id)

            #validate bloom_ability create if not exists
            bloom_ability = BloomAbility.where('lower(nombre) = ?', sc[:bloom_ability].try(:mb_chars).try(:downcase).try(:to_s)).first_or_create(:nombre => sc[:bloom_ability])

            #validate axis_program create if not exists
            axis_program = AxisProgram.where('lower(nombre) = ? AND assignature_id = ?', sc[:axis_program].try(:mb_chars).try(:downcase).try(:to_s), @assignature_id).first_or_create(:nombre => sc[:axis_program], :assignature_id => @assignature_id)

            #validates pme_ability create if not exists
            pme_ability = PmeAbility.where('lower(nombre) = ? AND assignature_id =? ', sc[:pme_ability].try(:mb_chars).try(:downcase).try(:to_s), @assignature_id).first_or_create(:nombre => sc[:pme_ability], :assignature_id => @assignature_id)

            #valides assignature_ability create if not exists
            assignature_ability = AssignatureAbility.where('lower(nombre) = ? AND assignature_id = ?', sc[:assignature_ability].try(:mb_chars).try(:downcase).try(:to_s), @assignature_id).first_or_create(:nombre => sc[:assignature_ability], :assignature_id => @assignature_id)

            #validates remedial, creates if not exists
            #remedial = Remedial.where('lower(nombre) = ?  AND level_id = ? AND content_id = ? ', sc[:remedial].try(:mb_chars).try(:downcase).try(:to_s), @level_id, content.id).where(:level_id => @level_id).first_or_create(:nombre => sc[:remedial], :content => content, :level_id => @level_id)
            remedial = Advice.where('lower(name) = ?', sc[:remedial].try(:mb_chars).try(:downcase).try(:to_s)).first_or_create(:name=> sc[:remedial])

            #validate learning_goal with the same name, assignature and level, create if doesnt exist
            #learning_goal = LearningGoal.where('lower(nombre) = ? AND assignature_id = ? AND level_id = ? ', sc[:learning_goal_number].try(:mb_chars).try(:downcase).try(:to_s), @assignature_id, @level_id ).first_or_create(:descripcion => sc[:learning_goal], :assignature_id => @assignature_id, :nombre => sc[:learning_goal_number],  :level_id => @level_id)
            lg_array = []
            u_array = []
            units = sc[:unit].try(:mb_chars).try(:downcase).try(:to_s).split(/[-\\,y]/).collect{|x| x.strip || x }
            
            if sc[:question_level].present?
            level = Level.where('lower(short_name) = ?', sc[:question_level].try(:mb_chars).try(:downcase).try(:to_s)).first
            else
            level = @level
            end
            learning_goals = sc[:learning_goal_number].try(:mb_chars).try(:downcase).try(:to_s).try(:split, /[-\\,y]/).try(:collect){|x| x.strip || x }
            if learning_goals.present?
            learning_goals.each do |lg|
              learning_goal = LearningGoal.where('lower(nombre) = ? AND assignature_id = ? AND level_id = ? ', lg.try(:mb_chars).try(:downcase).try(:to_s), @assignature_id, level.try(:id) ).first
              if learning_goal.present?
                lg_array.push(learning_goal)
                if units != nil 
                 units.each do |unit|
                   unit = Unit.where('lower(numero) = ? AND assignature_id = ? AND level_id = ?', unit, @assignature_id, level.try(:id)).first
                    #if unit hasnt that learning goal assigned, assign
                    #validar que el objetivo de aprendizaje existe
                     if lg_array.first.try(:units).exists?(unit.try(:id))
                       u_array.push(unit)
                     end
                 end
               end
              end
            end
          end
            #separate units from column
            #  units = sc[:unit].try(:mb_chars).try(:downcase).try(:to_s).split(/[-\\,y]/).collect{|x| x.strip || x }
            #validates unit, create if not exists
            # if units != nil
            #   units.each do |unit|
            #     unit = Unit.where('lower(numero) = ? AND assignature_id = ? AND level_id = ?', unit, @assignature_id, @level_id).first_or_create(:numero => unit, :assignature_id => @assignature_id,  :level_id => @level_id)
            #   #if unit hasnt that learning goal assigned, assign
            #       if unit.learning_goals.where(:id => learning_goal.id).count == 0
            #         unit.learning_goals << learning_goal
            #       end
            #   end
            # end

            #separate units from column

            #validate if exists


            #alternative_index is used to set the correct alternative that user creates in the next step
            #example = Question 1 , alternatives A , B , C . Correct C
            #this index is used to generate Guide, please check evaluation.erb model
            #we have to store this index (A,B,C,D or D) , not sure about where or how
            #guide_indexes.push({:question_index =>sc[:question_index], :correct => sc[:alternative_index]})

            #We create the question and add it to questions collection
            #again, not sure about when create the questions/evaluation because alternatives and question texts are created
            #in the next view
            #so we  add an input in view 1 where client say how many alternatives questions have
            #if sc[:alternative_index] == 'A' then position of correct alternative == 0 , B == 1
            ## Convert sc[:alternative_index] from "A","B","C" into 0,1,2,3
            alt_array = []
            (1..@alternatives_amount).each_with_index do |alt, index|
              alt = Alternative.new(:texto => "")
              if index == alternative_index(sc[:alternative_index])
                alt.correcta = true
              end
              alt.save
              alt_array.push(alt)
              # @question.alternatives << alt
            end
            array_obj.push({texto: "",content: content, difficulty_level: difficulty_level, axis: axis,bloom_ability: bloom_ability, axis_program: axis_program,pme_ability: pme_ability,assignature_ability: assignature_ability, assignature_id: @assignature_id, level_id: level.id, advice: remedial, alternatives: alt_array, learning_goals: lg_array, units: u_array})
            #before creating question we add empty alternatives with Alternative.correct in sc[:alternative_index]
            #
            # @questions_collection.push(@question)
          end
          @question = Question.create(array_obj)
            # @question.alternatives.build
          @questions_collection = @question
          evaluation = Evaluation.create(:nombre =>  @questions_data['evaluation_name'], :year =>  @questions_data['evaluation_year'].to_i, :evaluation_type_id => @evalution_type.id , :level_id => @level.id, :assignature_id => @assignature.id)
          evaluation.questions << @questions_collection.compact
          letters_array = ("A".."Z").to_a
          evaluation.create_index(evaluation.instruments.first, letters_array)
          session[:current_instrument] = evaluation.instruments.first.id

      respond_to do |format|
        format.js
        # if params[:form_data]['mass_mq'].present? #improve this validation if possible
        #   flash[:notice] =  'Ingreso masivo exitoso'
        #   redirect_to '/questions/mass_input_show'
        #   # format.json { render :show, status: :created, location: @question }
        # else
        #   render "mass_input"
        #   # format.json { render json: @question.errors, status: :unprocessable_entity }
        # end
      end
  end



  def get_assignature_dependants
    assignature = Assignature.find(params[:assignature_id]) || Assignature.first
    contents = assignature.contents.map{|c| [c.id, c.nombre] }
    axes = assignature.axes.map{|a| [a.id, a.nombre] }
    ass = assignature.assignature_abilities.map{|ass| [ass.id, ass.nombre]}
    pme = assignature.pme_abilities.map{|p| [p.id, p.nombre] }
    ap = assignature.axis_programs.map{|ap| [ap.id, ap.nombre] }
    res = { contents: contents, axes: axes , pme_abilities: pme, assignature_abilities: ass, axis_programs: ap}
    render json: res
  end


  def get_level_dependants
    assignature = Assignature.find(params[:assignature_id]) || Assignature.first
    level = Level.find(params[:level_id]) || Level.first
    learning_goals = LearningGoal.where(:assignature => assignature).where(:level => level).map{|l| [l.id, l.nombre] }
    res = { learning_goals: learning_goals}
    render json: res
  end

  def get_unit_dependants
    unit = Unit.find(params[:unit_id]) || Unit.first
    learning_goals = unit.learning_goals.map{|l| [l.id, l.nombre] }
    res = { learning_goals: learning_goals}
    render json: res
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(
      :advice_id, :texto, :assignature_id, :level_id, :bloom_ability_id, :axis_id, :axes_content_id,
      :ability_content_id, :pme_ability_id,:content_id ,:unit_id, :learning_goal_id,
      :difficulty_level_id , :axis_program_id, :assignature_ability_id, :group_question_id,
      alternatives_attributes: [:id, :texto, :correcta])
  end

  def mass_questions_params
    data = JSON.parse(params[:form_data])['mass_mq']
    #pass to hash and filter data
    data.reject { |s| s[0] == "REACTIVO" }.map{|info|
      {
        #params to create massive question to evaluation
        :question_index => info[0],
        :alternative_index => info[1],
        :content => info[2],
        :axis_program => info[3],
        :axis => info[4],
        :pme_ability => info[5],
        :learning_goal_number => info[7],
        :learning_goal => info[6],
        :unit => info[8],
        :assignature_ability => info[9],
        :bloom_ability => info[10],
        :difficulty_level => info[11],
        :remedial => info[12],
        :question_level => info[13]
        }
      }.select{|attrs| attrs[:question_index].present?}
  end

  def set_admin_menu
    @admin_menu = true
  end
end
