class GenerateComparativeJob < ActiveJob::Base
  include AbstractController::Rendering
  include ActionController::Helpers
  include ComparativesHelper
  include ApplicationHelper
  queue_as :default

  def perform(_params, current_user_id)
    @params = _params
    current_user = User.find_by(id: current_user_id)
    initialise_hash_variables
    if @report == '9'
      send('report_8')
    else
      send('report_'+@report)
    end

    
    #send("report_7")

    if @params["school"].present?
      sc = School.find(@params["school"].to_i)
    end
    #Consolidado_NIVEL_DIAGNOSTICO_2017_colegio
    file_name = case @params["report"].to_i
                when 1 then "INFORME_#{@report} #{Time.now.to_i}"
                when 2 then "INFORME__#{@report} #{Time.now.to_i}"
                when 3 then "INFORME__#{@report} #{Time.now.to_i}"
                when 4 then "INFORME__#{@report} #{Time.now.to_i}"
                when 5 then "CONSOLIDADO #{@params["proccess"]} #{@params["year"]} #{sc.nombre} #{@params["ending_year"]}".squish.upcase
                when 7 then "CONSOLIDADO SOSTENEDOR #{@params["proccess"]} #{@params["ending_year"]}".squish.upcase
                when 8 then "COMPARATIVO NIVEL #{@params["year"]} #{sc.nombre} #{@params["ending_year"]}".squish.upcase
                when 9 then "COMPARATIVO SIMCE #{@params["year"]} #{sc.nombre} #{@params["ending_year"]}".squish.upcase
                end

    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
      include ComparativesHelper
    end

    pdf_html = av.render(:pdf => "comparativo pdf", :disposition => "attachment", :template => "comparatives/compare_report.html.erb", :margin => {:top => 20, :bottom => 10, :right => 0, :left => 0}, :header => {:spacing => 2, html: {template: "results/report_pdf_header.pdf"}}, :footer => {right: "[page]/[topage]"}, :page_size => "Legal",
                         locals: {
                           :@school_student_by_level => @school_student_by_level,
                           :@report => @report,
                           :@params => @params,
                           :@proccesses => @proccesses,
                           #consolidado
                           :@result => @result,
                           :@school_result => @school_result,

                           :@for_school => @for_school,
                           :@assignatures => @assignatures,
                           :@comparative_years => @comparative_years,
                           :@evaluation_type => @evaluation_type,
                           :@levels => @levels,

                           #consolidado
                           :@avrg => @avrg,
                           :@school_avrg => @school_avrg,
                           :@school_avrg_totals => @school_avrg_totals,
                           :@school_avg_pme_proc => @school_avg_pme_proc,
                           :@avg_pme_level => @avg_pme_level,
                           :@school_avg_pme_level => @school_avg_pme_level,

                           :@avg_assignature_ability_level => @avg_assignature_ability_level,
                           :@avg_bloom_ability_level => @avg_bloom_ability_level,
                           :@avg_bloom_ability_totals => @avg_bloom_ability_totals,

                           #consolidado
                           :@avg_pme_ability_totals => @avg_pme_ability_totals,
                           :@school_avg_pme_ability_totals => @school_avg_pme_ability_totals,

                           :@avg_assignature_ability_totals => @avg_assignature_ability_totals,
                           :@answers => @answers,
                           :@school_answers => @school_answers,
                           :@school_answers_range => @school_answers_range,


                           #consolidado
                           :@ans => @ans,
                           :@school_ans => @school_ans,

                           #consolidado
                           :@pme_abilities_school => @pme_abilities_school,
                           :@school_pme_abilities_school => @school_pme_abilities_school,
                           :@pme_abilities_school_level => @pme_abilities_school_level,
                           :@assignature_abilities_school => @assignature_abilities_school,
                           :@bloom_abilities_school => @bloom_abilities_school,

                           #consolidado
                           :@result_pme_abilities => @result_pme_abilities,
                           :@school_result_pme_abilities => @school_result_pme_abilities,

                           :@result_assignature_abilities => @result_assignature_abilities,
                           :@result_bloom_abilities => @result_bloom_abilities,
                           :@colors_set => @colors_set,

                         })
    doc_pdf = WickedPdf.new.pdf_from_string(pdf_html)
    pdf_path = Rails.root.join("public/pdfs", "#{file_name}.pdf")
    File.open(pdf_path, "wb") do |file|
      file << doc_pdf
    end
    # if send_mail_status == true
    #   ProccessInstrumentMailer.send_answer_report(file_name, current_user).deliver
    # end
    new_obj = $service.buckets.find("reimagina-develop").objects.build("pdfs/#{file_name}.pdf")
    new_obj.content = open("public/pdfs/#{file_name}.pdf")
    new_obj.acl = :public_read
    new_obj.save
    UserMailer.send_comparatives_report(current_user, new_obj.url).deliver_now
    File.delete(pdf_path)
  end

  private

  def initialise_hash_variables

    #DAEM
    @school_achievement_of_school = {}
    @school_ans = {}
    @school_answers = {}
    @school_answers_range = {}
    @school_assignatures = {}
    @school_avrg = {}
    @school_avrg_totals = {}
    @school_avg_pme_level = {}
    @school_avg_pme_ability_totals = {}
    @school_avg_pme_ability_level = {}
    @school_levels = {}
    @school_result = {}
    @school_result_pme_abilities = {} 
    @pme_abilities_school_level = {}
    @school_avg_pme_proc = {}
    #individuales
    @achievement_of_school = {}
    @ans = {}
    @answers = {}
    @assignatures = {}
    @avrg = {}
    @avg_pme_level = {}
    @avg_assignature_ability_level = {}
    @avg_bloom_ability_level = {}
    @avg_bloom_ability_totals = {}
    @avg_pme_ability_totals = {}
    @avg_assignature_ability_totals = {}
    @avg_pme_ability_level = {}
    @levels = {}
    @result = {}
    @result_pme_abilities = {}
    @result_assignature_abilities = {}
    @result_bloom_abilities = {}
    @report = @params['report']
    #@report = "7"

    ids = if %w(2 4 7).include?(@report)
            User.find(@params["user"]).assigned_schools.collect(&:school_id)
          else
            [@params["school"]]
          end

    @for_school = School.find(ids)
    #@for_school = User.find(1673).assigned_schools.map { |s| s.school }

    @evaluation_type = case @params["report"].to_i
                       when 1 then EvaluationType.nivel_type
                       when 2 then EvaluationType.nivel_type
                       when 3 then EvaluationType.nivel_type
                       when 4 then EvaluationType.simce_type
                       when 5 then EvaluationType.nivel_type
                       when 7 then EvaluationType.nivel_type
                       when 8 then EvaluationType.nivel_type
                       when 9 then EvaluationType.simce_type
                       end
  end

  def report_1
    assign_variable_for_comparative_years

    school_levels_and_assignatures(ending_year, "report_1")

    @comparative_years.each do |year|
      calculate_school_achievement(year)
      calculate_levels_assignatures_students(year, "report_1")
    end
  end

  def report_2
    report_1
  end

  def report_3
    report_1
  end

  def report_4
    report_1
    data_grouped_by_school_for_report_4
  end

  def report_5
    assign_variable_for_comparative_years

    school_levels_and_assignatures(ending_year, "report_5")
    @assignatures.each do |assignature|
      @result_bloom_abilities[ending_year][assignature.id] = {}
      @avg_bloom_ability_level[ending_year][assignature.id] = {}
      @avg_bloom_ability_totals[ending_year][assignature.id] = {}
      @result_pme_abilities[ending_year][assignature.id] = {}
      @avg_pme_level[ending_year][assignature.id] = {}
      @avg_pme_ability_totals[ending_year][assignature.id] = {}
      @result_assignature_abilities[ending_year][assignature.id] = {}
      @avg_assignature_ability_level[ending_year][assignature.id] = {}
      @avg_assignature_ability_totals[ending_year][assignature.id] = {}
    end
    school_pme_abilities(ending_year, "report_5")
    school_assignature_abilities(ending_year, "report_5")
    calculate_levels_assignatures_students(ending_year, "report_5")
    school_level_pme_abilities(ending_year, "report_5")
  end

  def report_7
    assign_variable_for_consolidate_years

    school_levels_and_assignatures(ending_year, "report_7")
    @assignatures.each do |assignature|
      @for_school.each do |school|
        @school_result_pme_abilities[school][ending_year][assignature.id] = {}
        @school_avg_pme_level[school][ending_year][assignature.id] = {}
        @school_avg_pme_ability_totals[ending_year][assignature.id] = {}
      end
    end
    school_level_pme_abilities(ending_year, "report_7")
    calculate_levels_assignatures_students_daem(ending_year, "report_7")
  end

  def report_8
    ending_year =  @params["ending_year"]
    assign_variable_for_process ending_year
    school_levels_and_assignatures(ending_year, "report_8")
    @assignatures.each do |assignature|
      @proccesses.each do |school|
        @school_result_pme_abilities[school][ending_year][assignature.id] = {}
        @school_avg_pme_level[school][ending_year][assignature.id] = {}
        @school_avg_pme_ability_totals[ending_year][assignature.id] = {}
      end
    end

    @school_student_by_level = {}
    @colors = {}
      @proccesses.each do |pt|
        @school_student_by_level[pt] = {}
        @assignatures.each do |assignature|
          @school_student_by_level[pt][assignature.id] = {}
          @levels.each do |level|
            @school_student_by_level[pt][assignature.id][level.id] = {}
            ColorRange.compare_colors(assignature, level, @evaluation_type).each do |range|
              @school_student_by_level[pt][assignature.id][level.id][srip_and_downcase(range.nombre)] = 0
            end
          end
        end
      end

    school_level_pme_abilities(ending_year, "report_8")
    school_pme_abilities(ending_year, "report_8")
    calculate_levels_assignatures_students_daem(ending_year, "report_8")
  end

  def assign_variable_for_process year
    proctype_father = @params["report"] == '8' ? 1 : 2
    evaluation_type = @params["report"] == '8' ? 2 : 1
    ids = Order.where(:school_id => @params["school"], :year => year).last.proccesses.map{|p| p.proc_type.id }.uniq
    @proccesses =  ProcType.where(id: ids, proc_type_father_id: proctype_father).sort_by(&:priority).map{|p| p.id}

    @proccesses.each .each do |school|
      @school_achievement_of_school[school] = {}
      @school_answers[school] = {}
      @school_answers_range[school] = {}
      @school_ans[school] = {}
      @school_avg_pme_level[school] = {}
      @school_avg_pme_ability_level[school] = {}
      @school_result_pme_abilities[school] = {}
    end

    @proccesses.each do |school|
        @school_achievement_of_school[school][year] = {}
        @school_answers[school][year] = {}
        @school_answers_range[school][year] = {}
        @school_ans[school][year] = {}
        @school_avrg[year] = {}
        @school_avrg_totals[year] = {}
        @school_avg_pme_level[school][year] = {}
        @school_avg_pme_ability_totals[year] = {}
        @school_avg_pme_ability_level[school][year] = {}
        @school_result[year] = {}
        @school_result_pme_abilities[school][year] = {}
    end

    collect_all_answers_for_process year
  end

  def assign_variable_for_consolidate_years
    @for_school.each do |school|
      @school_achievement_of_school[school] = {}
      @school_answers[school] = {}
      @school_ans[school] = {}
      @school_avg_pme_level[school] = {}
      @school_avg_pme_ability_level[school] = {}
      @school_result_pme_abilities[school] = {}
    end

    @for_school.each do |school|
      comparative_years.each do |year|
        @school_achievement_of_school[school][year] = {}
        @school_answers[school][year] = {}
        @school_ans[school][year] = {}
        @school_avrg[year] = {}
        @school_avrg_totals[year] = {}
        @school_avg_pme_level[school][year] = {}
        @school_avg_pme_ability_totals[year] = {}
        @school_avg_pme_ability_level[school][year] = {}
        @school_result[year] = {}
        @school_result_pme_abilities[school][year] = {}
      end
    end
    comparative_years.each do |year|
      @for_school.each do |school|
        collect_all_answers_for_school_daem(school, year)
      end
    end
  end

  def assign_variable_for_comparative_years
    comparative_years.each do |year|
      @achievement_of_school[year] = {}
      @answers[year] = {}
      @ans[year] = {}
      @avrg[year] = {}
      @avg_pme_level[year] = {}
      @avg_assignature_ability_level[year] = {}
      @avg_bloom_ability_level[year] = {}
      @avg_bloom_ability_totals[year] = {}
      @avg_pme_ability_totals[year] = {}
      @avg_assignature_ability_totals[year] = {}
      @avg_pme_ability_level[year] = {}
      @result[year] = {}
      @result_pme_abilities[year] = {}
      @result_assignature_abilities[year] = {}
      @result_bloom_abilities[year] = {}
      collect_all_answers_for_school(year)
    end
  end

  def comparative_years
    @comparative_years = [@params["starting_year"], @params["ending_year"]].compact
  end

  def ending_year
    @comparative_years.last
  end

  def collect_all_answers_for_school(year)
    proccess = ProcType.where(nombre: @params["proccess"]).first
    if proccess && proccess.proc_type_father.short_name == "simce"
      @evaluation_type = EvaluationType.where(short_name: "simce").first
    end
    @ans[year] = Answer.joins(:question).joins(proccess_instrument: {proccess: {order: :school}, instrument: {evaluation: :evaluation_type}}).joins(proccess_instrument: :grade).joins(proccess_instrument: {proccess: :proc_type}).where('schools.id': @for_school.collect(&:id), 'grades.year': year, 'orders.year': year, 'evaluation_types.id': @evaluation_type.id, 'proc_types.nombre': @params["proccess"]).uniq
  end

  def collect_all_answers_for_process(year)
    #@ans[process][year] = Answer.joins(:question).joins(proccess_instrument: {proccess: {order: :school}, instrument: {evaluation: :evaluation_type}}).joins(proccess_instrument: :grade).joins(proccess_instrument: {proccess: :proc_type}).where('schools.id': @for_school.collect(&:id), 'grades.year': year, 'orders.year': year, 'evaluation_types.id': @evaluation_type.id, 'proc_types.nombre': @params["proccess"]).uniq
    proctype_father = @params["report"] == '8' ? 1 : 2
    evaluation_type = @params["report"] == '8' ? 2 : 1

    @proccesses.each do |process|
      if Answer.joins(:question).joins(proccess_instrument: {proccess: {order: :school}, instrument: {evaluation: :evaluation_type}}).joins(proccess_instrument: :grade).joins(proccess_instrument: {proccess: {proc_type: :proc_type_father}}).where('schools.id': @for_school.last.id, 'grades.year': year, 'orders.year': year, 'evaluation_types.id': evaluation_type, 'proc_types.id': process).uniq.count > 0
        @school_ans[process][year] = Answer.joins(:question).joins(proccess_instrument: {proccess: {order: :school}, instrument: {evaluation: :evaluation_type}}).joins(proccess_instrument: :grade).joins(proccess_instrument: {proccess: {proc_type: :proc_type_father}}).where('schools.id': @for_school.last.id, 'grades.year': year, 'orders.year': year, 'evaluation_types.id': evaluation_type, 'proc_types.id': process).uniq
      end
    end
    #aca hacerle sort a @proccesses por priority
  end

  def collect_all_answers_for_school_daem(school, year)
    proccess = ProcType.where(nombre: @params["proccess"]).first
    if proccess && proccess.proc_type_father.short_name == "simce"
      @evaluation_type = EvaluationType.where(short_name: "simce").first
    end
    @school_ans[school][year] = Answer.joins(:question).joins(proccess_instrument: {proccess: {order: :school}, instrument: {evaluation: :evaluation_type}}).joins(proccess_instrument: :grade).joins(proccess_instrument: {proccess: :proc_type}).where('schools.id': school.id, 'grades.year': year, 'orders.year': year, 'evaluation_types.id': @evaluation_type.id, 'proc_types.nombre': @params["proccess"]).uniq
  end
end
