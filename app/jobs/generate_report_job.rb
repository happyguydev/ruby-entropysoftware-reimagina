class GenerateReportJob < ActiveJob::Base
  include AbstractController::Rendering
  include ActionController::Helpers
  queue_as :default

  after_perform do |job|
    puts job.arguments.first
    ProccessInstrument.find(job.arguments.first).update_attributes(report_generated: true)
  end
  def perform(instrument_id, user_id, send_mail_status)
    ac = ActionController::Base.new()
    current_user = User.find_by(id: user_id)
    set_instrument(instrument_id, current_user)
    set_school(current_user)
    grade
    proceso = @proccess_instrument.proccess.proc_type.nombre
    asignatura = @proccess_instrument.instrument.evaluation.assignature.nombre
    nivel = @proccess_instrument.instrument.evaluation.level.nombre
    colegio = @proccess_instrument.proccess.order.school.nombre
    letra = @proccess_instrument.grade.try(:letra)
    name = "#{@proccess_instrument.id}_"+"Análisis"+'_'+proceso+'_'+asignatura+'_'+nivel+'_'+letra+'_'+colegio
    
    file_name = name.gsub(" ", "_")
    # get_short_name
    view = html = ActionView::Base.new(Rails.root.join('app/views'))
    view.class.include ApplicationHelper
    view.class.include Rails.application.routes.url_helpers
    rendered = view.render(:pdf => file_name, :disposition => 'attachment'    ,:template => 'results/report_pdf.html.erb',
    :margin => {:top => 20, :bottom =>10 },:header =>  { :spacing => 3, html: {            template: 'results/report_pdf_header.pdf' }},
    :footer => { right: '[page]/[topage]' },
    :page_size => nil,  :page_height => '33cm', :page_width => '22cm',
        :locals => {:@proccess_instrument => @proccess_instrument, :@instrument => @instrument, :@school => @school,
          :@letter => @letter,
          :@sufix => @sufix,
          :@answers => @answers,
          :@guides => @guides,
          :@students => @students,
          :@total_preguntas => @total_preguntas,
          :@student_results => @student_results,
          :@total_alumnos => @total_alumnos,
          :@asistencia => @asistencia,
          :@ausentes => @ausentes,
          :@color_ranges => @color_ranges,
          :@chart_colors => @chart_colors,
          :@color_stops => @color_stops,
          :@promedio_curso => @promedio_curso,
          :@colspan => @colspan,
          :@analisis_eje_title => @analisis_eje_title,
          :@analisis_eje => @analisis_eje,
          :@analisis_habilidad_title => @analisis_habilidad_title,
          :@analisis_habilidad => @analisis_habilidad,
          :@analisis_tabla_indicador_title => @analisis_tabla_indicador_title,
          :@analisis_tabla_indicador_1 => @analisis_tabla_indicador_1,
          :@analisis_tabla_indicador_2 => @analisis_tabla_indicador_2,
          :@tabla_contenido_habilidad => @tabla_contenido_habilidad,
          :@tot_oas => @tot_oas,
          :@tabla_lg => @tabla_lg,
          :@tabla_lh => @tabla_lh,
          :@abilities => @abilities,
          :@ranking_hab => @ranking_hab,
          :@hab_oa => @hab_oa,
          :@pme_oa_title => @pme_oa_title,
          :@pme_oa_title_1 => @pme_oa_title_1,
          :@pme_oa_title_2 => @pme_oa_title_2,
          :@pme_oa_title_3 => @pme_oa_title_3,
          :@pme_oa => @pme_oa,
          :@descendidos => @descendidos,
          :@glosario => @glosario,
          :@remediales_table => @remediales_table,
          :@colors => @colors,
          :@tabla_lg_tot => @tabla_lg_tot,
          :@headers_logro_simce => @headers_logro_simce,
          :@tabla_logro_simce => @tabla_logro_simce,
          :@alumno_pme => @alumno_pme,
          :@categories_heatmap => @categories_heatmap,
          :@resumen_estado_title => @resumen_estado_title})
    pdf = WickedPdf.new.pdf_from_string(rendered)
    save_path = Rails.root.join('public/pdfs',"#{file_name}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
    if send_mail_status == true
      ProccessInstrumentMailer.send_answer_report(file_name, current_user).deliver
    end
    new_obj = $service.buckets.find('reimagina-develop').objects.build("pdfs/#{file_name}.pdf")
    new_obj.content = open("public/pdfs/#{file_name}.pdf")
    new_obj.acl = :public_read
    new_obj.save
    File.delete(save_path)
  end

  def set_colors_hab(pme)
    Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,pme,@ranking_hab)
  end

  def to_porcentaje(puntaje)
    porcentaje = Result.to_porcentaje(puntaje,@instrument)
    porcentaje
  end

  def resolve_layout
    case action_name
    when "mass_input"
      "nomenu"
    else
      "application"
    end
  end

  def get_short_name
    tipo = @proccess_instrument.instrument.evaluation.evaluation_type.short_name
    curso = @proccess_instrument.instrument.evaluation.level.short_name
    asignatura = @instrument.evaluation.assignature.try(:short_name)
    @letter = 'b'

    # @letter = if tipo == 'psu'
    #             'h'
    #           elsif tipo == 'unidad'
    #             'b'
    #           elsif tipo == 'simce'
    #             curso.include?('_b') ? 'f' : 'g'
    #           elsif tipo == 'nivel'
    #             if curso.include? '_b'
    #               asignatura == 'hgcs' && (curso == 'octavo_b' || curso == 'septimo_b') ? 'c' : 'b'
    #             else
    #               'd'
    #             end
    #           end
    # if tipo == 'nivel' && curso.include?('_b')
    #   if asignatura == 'hgcs' && (curso == 'octavo_b' || curso == 'septimo_b')
    #     @letter = 'c'
    #   else
    #     @letter = 'b'
    #   end
    # end

    # if tipo == 'nivel' && curso.include?('_m')
    #   if asignatura == 'cn'
    #     @letter = 'b'
    #   elsif asignatura == 'hgcs'
    #     @letter = 'c'
    #   else
    #     @letter = 'd'
    #   end
    # end

    if tipo == 'psu'
      @letter = 'h'
    end

    if tipo == 'unidad'
      @letter = 'b'
    end

    if tipo == 'simce' && curso.include?('_b')
        @letter = 'f'
    end

    if tipo == 'simce' && curso.include?('_m')
        @letter = 'g'
    end

  end

      def set_report_b
        #partial analisis_habilidad
        @analisis_habilidad_title = 'HABILIDAD - INDICADOR'
        @analisis_habilidad = Result.analisis_habilidad('pme_ability',@proccess_instrument,self.asistencia[0])
        #partial tabla_indicador
        @tabla_indicador_title = 'HABILIDAD - INDICADOR'
        @tabla_lh =  Result.tabla_logro_habilidad(@proccess_instrument,self.asistencia[0],'%', 'pme_ability')
        @tabla_lg =  Result.tabla_logro_rangos(@proccess_instrument,self.asistencia[1] - self.asistencia[0],'pme_ability')
        #partial contenido_habilidad
        @analisis_tabla_indicador_title = 'CONTENIDO HABILIDAD - INDICADOR'
        @analisis_tabla_indicador_1 = 'HABILIDAD - INDICADOR'
        @analisis_tabla_indicador_2 = 'CONTENIDO'
        @tabla_contenido_habilidad = Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'pme_ability','content')
        #partial lista_preguntas
        @pme_oa_title = 'HABILIDAD - INDICADOR y OA/AE/OF'
        @pme_oa_title_1 = 'HABILIDAD - INDICADOR'
        @pme_oa_title_2 = 'CONTENIDO'
        @pme_oa_title_3 = 'OA/AE/OF'
        @pme_oa = Result.pme_oa(@proccess_instrument,self.asistencia[0],'pme_ability','content','learning_goal')
        @descendidos = Result.descendidos(@pme_oa)
        #partial glosario
        @glosario = Result.glosario(@instrument,'learning_goal')
        #partial remediales
        @remediales_table = Result.remediales(@instrument)
        #partial analisis_alumno_porcentaje
        @colors = Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,nil,nil)
        @tabla_lg_tot = Result.tabla_logro_totales(@proccess_instrument,@student_results,@ausentes)
        #partial analisis_alumno_indicador
        @abilities = Result.abilities(@instrument,'pme_ability')
        @ranking_hab = 'pme_ability'
        @analisis_alumno_indicador_title = 'HABILIDAD - INDICADOR'
        #partial resumen_estado
        @resumen_estado_title = 'HABILIDAD - INDICADOR'
        @alumno_pme = Result.tabla_promedio_alumno_pme(@proccess_instrument,'pme_ability')
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'pme_ability')
      end

      def set_report_c
        #partial analisis_habilidad
        @analisis_habilidad_title = 'HABILIDAD - INDICADOR PME'
        @analisis_habilidad = Result.analisis_habilidad('pme_ability',@proccess_instrument,self.asistencia[0])
        #partial tabla_indicador
        @tabla_indicador_title = 'EJE - INDICADOR'
        @tabla_lh =  Result.tabla_logro_habilidad(@proccess_instrument,self.asistencia[0],'%', 'assignature_ability')
        @tabla_lg =  Result.tabla_logro_rangos(@proccess_instrument,self.asistencia[1] - self.asistencia[0],'assignature_ability')
        #partial contenido_habilidad
        @analisis_tabla_indicador_title = 'CONTENIDO HABILIDAD PME'
        @analisis_tabla_indicador_1 = 'HABILIDAD - INDICADOR PME'
        @analisis_tabla_indicador_2 = 'CONTENIDO'
        @tabla_contenido_habilidad = Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'pme_ability','content')
        #partial lista_preguntas
        @pme_oa_title = 'HABILIDAD PME y OA/AE/OF'
        @pme_oa_title_1 = 'HABILIDAD - INDICADOR PME'
        @pme_oa_title_2 = 'CONTENIDO'
        @pme_oa_title_3 = 'OA/AE/OF'
        @pme_oa = Result.pme_oa(@proccess_instrument,self.asistencia[0],'pme_ability','content','learning_goal')
        @descendidos = Result.descendidos(@pme_oa)
        #partial glosario
        @glosario = Result.glosario(@instrument,'learning_goal')
        #partial remediales
        @remediales_table = Result.remediales(@instrument)
        #partial analisis_alumno_porcentaje
        @colors = Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,nil,nil)
        @tabla_lg_tot = Result.tabla_logro_totales(@proccess_instrument,@student_results,@ausentes)
        #partial analisis_alumno_indicador
        @abilities = Result.abilities(@instrument,'assignature_ability')
        @ranking_hab = 'assignature_ability'
        @analisis_alumno_indicador_title = 'HABILIDAD - INDICADOR'
        #partial resumen_estado
        @alumno_pme = Result.tabla_promedio_alumno_pme(@proccess_instrument,'assignature_ability')
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'assignature_ability')
        @resumen_estado_title = 'HABILIDAD - INDICADOR'
      end

      def set_report_d
        #partial analisis_habilidad
        @analisis_habilidad_title = 'APRENDIZAJE PME'
        @analisis_habilidad = Result.analisis_habilidad('assignature_ability',@proccess_instrument,self.asistencia[0])
        #partial tabla_indicador
        @tabla_indicador_title = 'HABILIDAD - INDICADOR'
        @columna_extra = Result.extra_column(@instrument,'pme_ability','assignature_ability')
        @colspan = 2
        @tabla_lh =  Result.tabla_logro_habilidad(@proccess_instrument,self.asistencia[0],'%', 'pme_ability')
        @tabla_lg =  Result.tabla_logro_rangos(@proccess_instrument,self.asistencia[1] - self.asistencia[0],'pme_ability')
        #partial contenido_habilidad
        @analisis_tabla_indicador_title = 'INDICADOR DE APRENDIZAJE'
        @analisis_tabla_indicador_1 = 'APRENDIZAJE PME'
        @analisis_tabla_indicador_2 = 'HABILIDAD - INDICADOR'
        @tabla_contenido_habilidad = Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'assignature_ability','pme_ability')
        #partial lista_preguntas
        @pme_oa_title = 'HABILIDAD - INDICADOR Y APRENDIZAJE'
        @pme_oa_title_1 = 'INDICADOR - HABILIDAD'
        @pme_oa_title_2 = 'APRENDIZAJE'
        @pme_oa_title_3 = 'CONTENIDO'
        @pme_oa = Result.pme_oa(@proccess_instrument,self.asistencia[0],'pme_ability','assignature_ability','content')
        @descendidos = Result.descendidos(@pme_oa)
        #partial glosario
        @glosario = Result.glosario(@instrument,'learning_goal')
        #partial remediales
        @remediales_table = Result.remediales(@instrument)
        #partial analisis_alumno_porcentaje
        @colors = Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,nil,nil)
        @tabla_lg_tot = Result.tabla_logro_totales(@proccess_instrument,@student_results,@ausentes)
        #partial analisis_alumno_indicador
        @analisis_alumno_indicador_title = 'HABILIDAD - INDICADOR'
        @abilities = Result.abilities(@instrument,'pme_ability')
        @ranking_hab = 'pme_ability'
        #partial resumen_estado
        @alumno_pme = Result.tabla_promedio_alumno_pme(@proccess_instrument,'pme_ability')
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'pme_ability')
        @resumen_estado_title = 'HABILIDAD - INDICADOR'
      end

      def set_report_f
        #partial analisis_habilidad
        @analisis_habilidad_title = 'HABILIDAD - INDICADOR PME'
        @analisis_habilidad = Result.analisis_habilidad('pme_ability',@proccess_instrument,self.asistencia[0])
        #partial contenido_habilidad
        @analisis_tabla_indicador_title = 'CONTENIDO HABILIDAD - INDICADOR PME'
        @analisis_tabla_indicador_1 = 'HABILIDAD - INDICADOR PME'
        @analisis_tabla_indicador_2 = 'CONTENIDO'
        @tabla_contenido_habilidad = Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'pme_ability','content')
        @hab_oa =  Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'pme_ability','learning_goal')
        @tot_oas = Result.general_oas(@proccess_instrument,self.asistencia[0])
        #partial lista_preguntas
        @pme_oa_title = 'HABILIDAD - INDICADOR y OA/AE/OF'
        @pme_oa_title_1 = 'HABILIDAD - INDICADOR'
        @pme_oa_title_2 = 'CONTENIDO'
        @pme_oa_title_3 = 'OA/AE/OF'
        @pme_oa = Result.pme_oa(@proccess_instrument,self.asistencia[0],'pme_ability','content','learning_goal')
        @descendidos = Result.descendidos(@pme_oa)
        #partial glosario
        @glosario = Result.glosario(@instrument,'learning_goal')
        #partial remediales
        @remediales_table = Result.remediales(@instrument)
        #partial analisis_alumno_porcentaje
        @colors = Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,nil,nil)
        @tabla_lg_tot = Result.tabla_logro_totales(@proccess_instrument,@student_results,@ausentes)
        #partial promedio SIMCE alumno
        @headers_logro_simce,@tabla_logro_simce = Result.logro_alumno_oa(@proccess_instrument,'learning_goal',@student_results,@total_preguntas)
        #partial resumen_estado
        @alumno_pme = Result.tabla_promedio_alumno_pme_simce(@proccess_instrument,'pme_ability',@student_results,@total_preguntas)
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'pme_ability')
        @resumen_estado_title = 'HABILIDAD - INDICADOR'

      end

      def set_report_g
        #partial analisis_eje
        @analisis_eje_title = 'EJE'
        @analisis_eje = Result.analisis_habilidad('axis',@proccess_instrument,self.asistencia[0])
        #partial analisis_habilidad
        @analisis_habilidad_title = 'HABILIDAD - INDICADOR'
        @analisis_habilidad = Result.analisis_habilidad('pme_ability',@proccess_instrument,self.asistencia[0])
        #partial contenido_habilidad
        @analisis_tabla_indicador_title = 'CONTENIDOS Y OBJETIVOS FUNDAMENTALES DE CADA EJE'
        @analisis_tabla_indicador_1 = 'EJE'
        @analisis_tabla_indicador_2 = 'CONTENIDO'
        @tabla_contenido_habilidad = Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'pme_ability','content')
        @hab_oa =  Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'pme_ability','learning_goal')
        @tot_oas = Result.general_oas(@proccess_instrument,self.asistencia[0])
        #partial lista_preguntas
        @pme_oa_title = 'HABILIDAD - INDICADOR Y OA/AE/OF'
        @pme_oa_title_1 = 'INDICADOR - HABILIDAD'
        @pme_oa_title_2 = 'CONTENIDO'
        @pme_oa_title_3 = 'OA/AE/OF'
        @pme_oa = Result.pme_oa(@proccess_instrument,self.asistencia[0],'pme_ability','content','learning_goal')
        @descendidos = Result.descendidos(@pme_oa)
        #partial glosario
        @glosario = Result.glosario(@instrument,'learning_goal')
        #partial remediales
        @remediales_table = Result.remediales(@instrument)
        #partial analisis_alumno_porcentaje
        @colors = Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,nil,nil)
        @tabla_lg_tot = Result.tabla_logro_totales(@proccess_instrument,@student_results,@ausentes)
        #partial promedio SIMCE alumno
        @headers_logro_simce,@tabla_logro_simce = Result.logro_alumno_oa(@proccess_instrument,'learning_goal',@student_results,@total_preguntas)
        #partial resumen_estado
        @alumno_pme = Result.tabla_promedio_alumno_pme_simce(@proccess_instrument,'pme_ability',@student_results,@total_preguntas)
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'pme_ability')
        @resumen_estado_title = 'HABILIDAD - INDICADOR'
      end

      def set_report_h
        #partial analisis_eje
        @analisis_eje = Result.analisis_habilidad('axis',@proccess_instrument,self.asistencia[0])
        @analisis_eje_title = 'EJE'
        #partial analisis_habilidad
        @analisis_habilidad_title = 'HABILIDAD COGNITIVA'
        @analisis_habilidad = Result.analisis_habilidad('bloom_ability',@proccess_instrument,self.asistencia[0])
        #partial contenido_habilidad
        @analisis_tabla_indicador_title = 'CONTENIDOS DE CADA EJE'
        @analisis_tabla_indicador_1 = 'EJE'
        @analisis_tabla_indicador_2 = 'CONTENIDO'
        @tabla_contenido_habilidad = Result.habilidad_contenido_pme(@proccess_instrument,self.asistencia[0],'axis','content')
        #partial lista_preguntas
        @pme_oa_title = 'CONTENIDO Y HABILIDAD'
        @pme_oa_title_1 = 'EJE'
        @pme_oa_title_2 = 'CONTENIDO'
        @pme_oa_title_3 = 'HABILIDAD COGNITIVA'
        @pme_oa = Result.pme_oa(@proccess_instrument,self.asistencia[0],'axis','content','bloom_ability')
        @descendidos = Result.descendidos(@pme_oa)
        #partial analisis_alumno_porcentaje
        @colors = Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,nil,nil)
        @tabla_lg_tot = Result.tabla_logro_totales(@proccess_instrument,@student_results,@ausentes)
        #partial resumen_estado
        @alumno_pme = Result.tabla_promedio_alumno_pme_psu(@proccess_instrument,'content',@student_results,@total_preguntas)
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'content')
        @resumen_estado_title = 'CONTENIDO'
      end

  def asistencia
    [@proccess_instrument.answers.pluck(:student_id).uniq.count, @proccess_instrument.grade.students.count]
  end
  def grade
    ## Resultado curso
    @sufix = Result.set_sufix(@instrument)
    @answers = @proccess_instrument.answers
    @guides = @instrument.guides
    #@students = @proccess_instrument.grade.students
    @students = Student.where(:id => @proccess_instrument.answers.where.not(:letra => nil).pluck(:student_id).uniq)
    @total_preguntas = @instrument.evaluation.questions.count
    @student_results = Result.student_results(@students,@answers,@guides)
    @total_alumnos = asistencia[1]
    @asistencia = asistencia[0]
    @ausentes = asistencia[1] - asistencia[0]
    @color_ranges = Result.color_ranges(@instrument)
    @chart_colors = Result.color_set
    @color_stops = Result.set_stops(@instrument)
    tipo = @instrument.evaluation.evaluation_type.short_name
    curso = @instrument.evaluation.level.short_name
    asignatura = @instrument.evaluation.assignature.short_name
    @promedio_curso = Result.promedio_curso(@instrument,@student_results,@total_preguntas,self.asistencia[0])
    @colspan = 1
    get_short_name
    self.send('set_report_'+@letter)
  end

  def set_instrument(id, current_user)
    @proccess_instrument = ProccessInstrument.find(id)
    @instrument = @proccess_instrument.instrument
    #raise exception if client tries to download evaluations outside its scope changing the URL
  end

  def set_school(current_user)
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