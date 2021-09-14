class InstrumentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_admin_menu
  before_action :set_instrument, only: [:show, :edit, :update, :destroy, :guide, :generate_guide]
  respond_to :docx

  # GET /instruments
  # GET /instruments.json
  def index
    @instruments = Instrument.all
    respond_to do |format|
      format.html
      format.json { render json: InstrumentDatatable.new(view_context) }
    end
  end

  def instrument_by_order
    respond_to do |format|
      format.json do
        render json: InstrumentsByOrderDatatable.new(view_context, order_id: params[:order_id])
      end
    end
  end

  # GET /instruments/1
  # GET /instruments/1.json..
  def show
    @positions = @instrument.instrument_questions_positions.order('position ASC')
    respond_to do |format|
      format.html do
        render  :pdf => "#{@instrument.nombre.gsub(" ", "_")}",
      :disposition => 'inline',
      :page_size => nil,  :page_height => '33cm', :page_width => '22cm',
      :template => 'instruments/instrument_document.html.erb',
      :margin => {:top => 15, :bottom =>15 },
      :header => { html: { template: 'instruments/header.pdf.erb', }, :spacing => 5},
      :footer => { right: '[page]' }
    end

    format.pdf do
        render  :pdf => "#{@instrument.nombre.gsub(" ", "_")}",
      :disposition => 'attachment'    ,
      :page_size => nil,  :page_height => '33cm', :page_width => '22cm',
      :template => 'instruments/instrument_document.html.erb',
      :margin => {:top => 15,:bottom =>15 },
      :header => { html: {template: 'instruments/header.pdf.erb', },:spacing => 5},
      :footer => { right: '[page]' }
    end
  end
end

# GET /instruments/new
def new
  @instrument = Instrument.new
end

# GET /instruments/1/edit
def edit
end

  def mass_input
    @data = JSON.parse(params[:form_data])
    @proccess_instrument = ProccessInstrument.find(@data['proccess_instrument_id'])
    if @proccess_instrument.answers.empty?
      respond_to do |format|
        mass_answers_params.each do |a|
            ans_status = @proccess_instrument.instrument.guides.where(question_id: a[:question_id]).last.alternative_index == a[:letra]
            Answer.create(proccess_instrument: @proccess_instrument, question_id: a[:question_id], student_id: a[:student_id], letra: a[:letra], correct: ans_status)
        end.all?
        format.js {render inline: "window.location = '/instruments'"}
      end
    else
      render text: "Ya se ingresaron las respuestas para este instrumento"
    end
  end

# POST /instruments
# POST /instruments.json
def create
  @instrument = Instrument.new(instrument_params)
  respond_to do |format|
    if @instrument.save
      format.html { redirect_to instruments_url, notice: 'Instrumento creado con éxito.' }
      format.json { render :show, status: :created, location: @instrument }
    else
      format.html { render :new }
      format.json { render json: @instrument.errors, status: :unprocessable_entity }
    end
  end
end

# PATCH/PUT /instruments/1
# PATCH/PUT /instruments/1.json
def update
  respond_to do |format|
    if @instrument.update(instrument_params)
      format.html { redirect_to @instrument, notice: 'Instrumento actualizado con éxito.' }
      format.json { render :show, status: :ok, location: @instrument }
    else
      format.html { render :edit }
      format.json { render json: @instrument.errors, status: :unprocessable_entity }
    end
  end
end

def sort_questions
  respond_to do |format|
    begin
      questions = params[:instrument_questions_position]
      questions.each_with_index do |q, i|
        position = InstrumentQuestionsPosition.find(q)
        position.update(position: (i+1))
      end

      format.json { render json: { message: "success" }, status: :ok }
    rescue StandardError => e
      format.json { render json: { error: "an error occurred" }, status: :unprocessable_entity }
    end
  end
end

def sort_alternatives
  alternatives = params[:instrument_alternatives_position]
  letters_arr = ("A".."Z").to_a

  respond_to do |format|
    begin
      alternatives.each_with_index do |a, i|
        position = InstrumentAlternativesPosition.find(a)
        position.update(position: letters_arr[i])
      end

      format.json { render json: { message: "success" }, status: :ok }
    rescue StandardError => e
      format.json { render json: { error: "an error occurred" }, status: :unprocessable_entity }
    end
  end
end

  def mass_remedials

    @question_remedials = @instrument.instrument_questions_positions.order('position ASC').collect(&:question).uniq
    @alternative_remedials = @instrument.guides.order('question_index ASC').collect(&:alternative_index)

      header = ["ID","REACTIVO","CLAVE","CONTENIDO","EJE EN PROGRAMA","EJE DE APRENDIZAJE","HABILIDAD/INDICADOR","OA-AE-OF","Nº DE OA-AE-OF","NIVEL","UNIDAD","HABILIDAD PROPIA DE LA ASIGNATURA","HABILIDAD COGNITIVA","NIVEL DE DIFICULTAD","REMEDIALES"];
      questions_partial = []
      questions_global = []
      questions_global.push(header);

    @question_remedials.each_with_index do |q,i| 
        questions_partial.push(q.id)
        questions_partial.push(i+1)
        questions_partial.push(@alternative_remedials[i].presence || "NINGUNO")
        questions_partial.push(q.try(:content).try(:nombre).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push(q.try(:axis_program).try(:nombre).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push(q.try(:axis).try(:nombre).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push(q.try(:pme_ability).try(:nombre).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push("DESCRIPCIONES EN MACROTABLA");
        questions_partial.push(q.try(:learning_goals).try(:map){|oa| oa.try(:nombre)}.try(:sort).try(:join, ("-")).presence || "NINGUNO");
        questions_partial.push(q.try(:level).try(:short_name).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        #questions_partial.push(q.try(:learning_goals).try(:map){|oa| oa.try(:units).try(:map){|unit| unit.try(:numero)}.try(:sort).try(:join, ("-"))}.presence || "NIGUNO" );
        questions_partial.push(q.try(:units).try(:map){|u| u.try(:numero)}.try(:sort).try(:join, ("-")).presence || "NINGUNO");
        questions_partial.push(q.try(:assignature_ability).try(:nombre).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push(q.try(:bloom_ability).try(:nombre).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push(q.try(:difficulty_level).try(:name).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_partial.push(q.try(:advice).try(:name).try(:mb_chars).try(:upcase).to_s.presence || "NINGUNO")
        questions_global.push(questions_partial);
        questions_partial = [];
      end 

    @questions_global = questions_global
  end

# DELETE /instruments/1
# DELETE /instruments/1.json
def destroy
  @instrument.destroy
  respond_to do |format|
    format.html { redirect_to instruments_url, notice: 'Instrumento borrado con éxito.' }
    format.json { head :no_content }
  end
end

def generate_guide
  respond_to do |format|
    begin
      @instrument.guides.destroy_all
      @instrument.instrument_alternatives_positions.each_with_index { |a, i|
        if a.alternative.correcta
          Guide.create(
            instrument_id: @instrument.id, question_id: a.question_id, alternative_id: a.alternative_id,
            alternative_index: a.position, question_index: a.instrument_questions_position.position)
        end
      }

      format.js {}
    rescue StandardError => e
      @error = true

      format.js {}
    end
  end
end

def guide
  respond_to do |format|
    format.html
    format.json { render json: @instrument.guides }
    format.pdf do
        render  :pdf => "#{@instrument.nombre.gsub(" ", "_")}",
      :disposition => 'attachment'    ,
      :page_size => nil,  :page_height => '33cm', :page_width => '22cm',
      :template => 'instruments/guide_pdf.html.erb',
      :margin => {:top => 15,:bottom =>15 },
      :footer => { right: '[page]' }
    end
  end
end

def set_style(instrument)
  if instrument.present?
    if (instrument.evaluation.level.short_name == "primero_b" || instrument.evaluation.level.short_name == "segundo_b")
      "grande"
    else
      "chico"
    end
  end
end
helper_method :set_style

private
# Use callbacks to share common setup or constraints between actions.
def set_instrument
    
    @instrument = Instrument.find(params[:id])
    #raise exception if client tries to download evaluations outside its scope changing the URL
    if current_user.has_school_client_role?
      bool = false
      current_user.assigned_schools.each do |ass|
        if ProccessInstrument.joins(proccess:[:order => :school]).where("school_id = #{ass.school_id}").where(:instrument => @instrument ).count == 1
          bool = true
        end
      end
          if bool == false 
      raise 'acceso denegado'
    end
  end

end

# Never trust parameters from the scary internet, only allow the white list through.
def instrument_params
  params.require(:instrument).permit(:nombre, :evaluation_id)
end

def set_admin_menu
  @admin_menu = true
end

def auth_client
  puts "#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  if current_user.has_school_client_role?
    current_user.assigned_schools.each do |ass|
      if ProccessInstrument.joins(proccess:[:order => :school]).where("school_id = #{ass.school_id}").where(:instrument => @instrument ).count > 0
        authorize! :download, @instrument
      end
    end
  end
end

end
