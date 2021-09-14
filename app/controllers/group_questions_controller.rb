class GroupQuestionsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_group_question, only: [:show, :edit, :update, :destroy, :add_new, :add_existing]
  before_action :set_admin_menu
  skip_before_filter :verify_authenticity_token
  # GET /group_questions
  # GET /group_questions.json
  def index
    @group_questions = GroupQuestion.all

    respond_to do |format|
      format.html
      format.json { render json: GroupQuestionDatatable.new(view_context) }
    end
  end

  # GET /group_questions/1
  # GET /group_questions/1.json
  def show
    @question = @group_question.questions.new
    @question.alternatives.build
  end

  # GET /group_questions/new
  def new
    @group_question = GroupQuestion.new
  end

  # GET /group_questions/1/edit
  def edit
  end

  # POST /group_questions
  # POST /group_questions.json
  def create
    @group_question = GroupQuestion.new(group_question_params)
    params[:question_ids] = params[:group_question][:question_ids]
    respond_to do |format|
      if @group_question.save
        if params[:question_ids].present?
          obj_hash = Hash.new
          params[:question_ids].map {|c| obj_hash[c.to_i] = {group_question_id: @group_question.id}}
          Question.update(obj_hash.keys,obj_hash.values)
          # params[:question_ids].each do |question_id|
          #   @question = Question.find(question_id)
          # end
        end

        format.html { redirect_to @group_question, notice: 'Grupo de preguntas creado con éxito.' }
        # format.json { render :show, status: :created, location: @group_question }
        format.js
      else
        format.html { render :new }
        # format.json { render json: @group_question.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /group_questions/1
  # PATCH/PUT /group_questions/1.json
  def update
    params[:question_ids] = params[:group_question][:question_ids]
    respond_to do |format|
      if @group_question.update(group_question_params)
       if params[:question_ids].present?
          @group_question.questions.update_all(:group_question_id=> nil)
           obj_hash = Hash.new
          params[:question_ids].map {|c| obj_hash[c.to_i] = {group_question_id: @group_question.id}}
          Question.update(obj_hash.keys,obj_hash.values)
          # params[:question_ids].each do |question_id|
          #   @question = Question.find(question_id)
          #   @question.update_attributes(group_question_id: @group_question.id)
          # end
       end
         flash[:notice] = 'Grupo de preguntas actualizado con éxito.'

        format.html { redirect_to @group_question}
        # format.json { render :show, status: :ok, location: @group_question }
         format.js# { render 'update', notice: 'Pregunta actualizada con éxito.' }
      else
        format.html { render :edit }
        # format.json { render json: @group_question.errors, status: :unprocessable_entity }
         format.js
      end
    end
  end

  def add_existing
    @questions = Question.where(group_question_id: nil)
  end

  def add_question
    @question = Question.find(params[:question_id])
    if @question.group_question_id.nil?
      @question.update_attributes(group_question_id: params[:id])
      @assigned = true
    end
  end

  def remove_question
    @question = Question.find(params[:question_id])

    begin
      @commit = params[:commit]

      case @commit
        when "unassign"
          @question.update_attributes(group_question_id: nil)
        when "delete"
          @question.destroy  
        end
    rescue StandardError => e
      @error = true
      @question.update_attributes(group_question_id: nil)
    end
  end

  def add_new
    @question = @group_question.questions.new
    @question.alternatives.build
  end

  # DELETE /group_questions/1
  # DELETE /group_questions/1.json
  def destroy
    @group_question.destroy
    respond_to do |format|
      format.html { redirect_to group_questions_url, notice: 'Grupo de preguntas borrado con éxito.' }
      format.json { head :no_content }
    end
  end

 def edit_statement
  @question = Question.find(params[:question_id])
 end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group_question
    @group_question = GroupQuestion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_question_params
    params.require(:group_question).permit(:statement)
  end



  def set_admin_menu
    @admin_menu = true
  end
end
