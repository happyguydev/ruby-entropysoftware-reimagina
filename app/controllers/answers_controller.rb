class AnswersController < ApplicationController
  load_and_authorize_resource

  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :set_instrument, except: [:mass_input]
  before_action :set_admin_menu
  before_action :set_school, only: [:new]

  # GET /answers
  # GET /answers.json
  def index
    # @answers = Answer.all
    redirect_to new_proccess_instrument_answer_path(@proccess_instrument)
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  def mass_input
    @data = JSON.parse(params[:form_data])
    @proccess_instrument = ProccessInstrument.find(@data['proccess_instrument_id'])
    alt = "abcdefghijklmnopq"    
    if @proccess_instrument.answers.empty?
      respond_to do |format|
        mass_answers_params.each do |a|
          if a[:letra].present? && (a[:letra].downcase.strip.in? alt) && (a[:letra].length == 1)            
            ans_status = @proccess_instrument.instrument.guides.where(question_id: a[:question_id]).last.alternative_index.try(:upcase).try(:strip) == a[:letra].try(:upcase).try(:strip)
            Answer.create(proccess_instrument: @proccess_instrument, question_id: a[:question_id], student_id: a[:student_id], letra: a[:letra], correct: ans_status)
          end
        end.all?
        cookies[:added_to_sidekiq] = true
        GenerateReportJob.set(wait: 5.seconds).perform_later(@data["proccess_instrument_id"],current_user.id, @data["send_mail_status"])
        format.js {render inline: "window.location = '/proccess_instruments/admin'"}
      end
    else
      render text: "Ya se ingresaron las respuestas para este instrumento"
    end
  end


  # POST /answers
  # POST /answers.json
  def create
    if @proccess_instrument.answers.empty?
      alt = "abcdefghijklmnopq"
      saved = params[:answer][:answers].map do |a|
        student_id = a[0].to_i
        a[1].each do |k, v|
          if v[:letra].present? && (v[:letra].downcase.strip.in? alt) && (v[:letra].length == 1)
            ans_status = @proccess_instrument.instrument.guides.where(question_id: k.to_i).last.alternative_index.try(:upcase).try(:strip) == v[:letra].try(:upcase).try(:strip)
            Answer.create(proccess_instrument: @proccess_instrument, question_id: k.to_i, student_id: student_id, letra: v[:letra], correct: ans_status)
          end
        end
      end.all?

      respond_to do |format|
        if saved
          format.html { redirect_to admin_proccess_instruments_path , notice: 'Respuestas Ingresadas.' }
          format.json { render json: @answers, status: :ok }
        else
          format.html { render :new }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    else
      render text: "Ya se ingresaron las respuestas para este instrumento"
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update

    # No deberias poder updatear
    #
    #    p "###################################"
    #    p params[:instrument].inspect
    #
    #    p "###################################"
    #    respond_to do |format|
    #      if @answer.update(answer_params)
    #        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
    #        format.json { render :show, status: :ok, location: @answer }
    #      else
    #        format.html { render :edit }
    #        format.json { render json: @answer.errors, status: :unprocessable_entity }
    #      end
    #    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_instrument
    @instrument = ProccessInstrument.find(params[:proccess_instrument_id]).instrument
    @proccess_instrument = ProccessInstrument.find(params[:proccess_instrument_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:instrument_id, :question_id, :student_id, :letra)
  end

  def mass_answers_params
    data = JSON.parse(params[:form_data])['mass_answers']
    answers_list = []
    data.each do |e|
      student = Student.where(:rut => e[0] )
      question_index = Guide.where(:instrument_id => @proccess_instrument.instrument_id).order(:question_index).map{|i| i.question_id}
      if(student.present?)
        e.each_with_index do |c,i|
          if i > 2
              #agregar pregunta al hash
              answers_list.push({:student_id => student.first.id, :letra => c, :question_id => question_index[i-3]})
          end
        end
      end
    end
    answers_list
  end

  private
    def set_admin_menu
      if current_user.has_school_client_role?
        @school_client_menu = true
      else
        @admin_menu = true
      end
    end

    def set_school
      if current_user.user_type.role.eql?('client')
        if current_user.has_role?(:daem)
          if session[:school_id].present?
            @school = School.find(session[:school_id]) rescue (session[:school_id] = nil)
          else
            @assigned_schools = current_user.assigned_schools
          end
        else
          @school = current_user.assigned_schools.try(:first).try(:school)

        end
      end
    end
end
