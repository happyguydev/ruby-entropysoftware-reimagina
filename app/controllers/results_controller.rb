    class ResultsController < ApplicationController
      skip_load_and_authorize_resource only: [:report_pdf, :report]
      skip_before_action :verify_authenticity_token
      before_action :set_instrument, only: [:index, :grade,:report_pdf,:report ]
      before_action :set_admin_menu
      before_action :set_school, only: [:report_pdf, :report]
      before_action :grade, only: [:report_pdf,:report ]
      layout :resolve_layout
      #before_action :set_titles, only: [:report_pdf, :report ]
      #before_action :report, only: [:report_pdf ]
      include MassInputConcern
      require 'json'
      helper_method :set_colors_hab
      helper_method :to_porcentaje

      def index
      end

      def mass_input
        @fluid = true
      end

      def download_report
        rid = params["rid"]
        report = ReportsBypass.find(rid)
        file = File.open(report.report.path)
        send_file file, :type => 'text/html; charset=utf-8', :filename => "#{report.nombre}.pdf"
        file.close
      end

      def mass_input_pdf
        datos = JSON.parse(params[:form_data])

        pauta = datos["pauta"]
        respuestas = datos["respuestas"]
        nombre_instrumento = datos["nombre_instrumento"]
        nombre_colegio = datos["nombre_colegio"]
        asignatura = datos["asignatura"]
        curso = datos["curso"]

        @vc = view_context
        @data = prepareReport(datos)

        html = render_to_string 'mass_input_report', :layout => 'to_pdf'

        header = render_to_string 'report_header', layout: false
        footer = render_to_string 'report_footer', layout: false

        pdf = WickedPdf.new.pdf_from_string(html, {
          margin: {
            top: 43,
            bottom: 33,
            left: 0,
            right: 0
            },
          header: {
            :spacing => 10,
            content: header
            },
          footer: {
            content:  footer
            },
          javascript_delay: 10000,
          encoding: 'utf-8',
          page_size: 'A4'
          })

        pdf_report = ReportsBypass.new(nombre: "#{nombre_colegio}-#{nombre_instrumento}-#{asignatura}-#{curso}", report: StringIO.new(pdf))

        pdf_report.save

        render json: { url: "/results/download_report/#{pdf_report.id}" }
      end

      def mass_input_post_data
        pauta = params[:pauta]
        respuestas = params[:respuestas]
        nombre_instrumento = params[:nombre_instrumento]
        nombre_colegio = params[:nombre_colegio]
        asignatura = params[:asignatura]
        curso = params[:curso]

        @data = prepareReport(JSON.parse(params[:form_data]))

        #render 'mass_input_report', layout: false
        render json: @data
      end

      def report
        #    @color_ranges = color_ranges
        #    @asistencia, @total_alumnos = asistencia
        #    @ausentes = @total_alumnos - @asistencia
        #    @promedio_curso = promedio_curso
        #    @logro_curso = logro_curso
        #    @tabla_lh = tabla_logro_habilidad
        #    @tabla_lg = tabla_logro_rangos
        #    @tabla_lg_tot = tabla_logro_totales
        #    @pme_table = habilidad_pme
        #    @assignature_ability_table = habilidad_asignatura
        #    @pme_oa = pme_oa
        #    @descendidos = descendidos
        #    @remediales_table = remediales_table
        #    @ability_table = habilidad_contenido_pme
        #    @glosario_objectivo_aprendizaje = glosario_objectivo_aprendizaje
        #    @alumno_pme = tabla_promedio_alumno_pme
        #    @alumno_assignature_ability = tabla_promedio_alumno_assignature_ability
        #    @totals = self.grade
        #    self.grade
        #    @colors = set_colors
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
        @total_alumnos = self.asistencia[1]
        @asistencia = self.asistencia[0]
        @ausentes = self.asistencia[1] - self.asistencia[0]
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

      def report_pdf
        proceso = @proccess_instrument.proccess.try(:proc_type).try(:nombre)
        asignatura = @proccess_instrument.instrument.evaluation.assignature.nombre
        nivel = @proccess_instrument.instrument.evaluation.level.nombre
        colegio = @proccess_instrument.proccess.order.school.nombre
        letra = @proccess_instrument.grade.try(:letra)        
        name = "Análisis"+'_'+proceso+'_'+asignatura+'_'+nivel+'_'+letra+'_'+colegio
        file_name = name.gsub(" ", "_")
       
        # get_short_name
        render  :pdf => file_name, :disposition => 'attachment'    ,:template => 'results/report_pdf.html.erb', :margin => {:top => 20, :bottom =>10 },:header =>  { :spacing => 3, html: {            template: 'results/report_pdf_header.pdf' }}, :footer => { right: '[page]/[topage]' },
        :page_size => nil,  :page_height => '33cm', :page_width => '22cm'
      end

      def generate_report_pdf
        GenerateReportJob.set(wait: 5.seconds).perform_later(params[:id],params[:user_id],params[:send_mail_status])
        render nothing: true
      end

      def download_pdf
        @proccess_instrument = ProccessInstrument.find_by(id: params[:id])
        proceso = @proccess_instrument.proccess.try(:proc_type).try(:nombre)
        asignatura = @proccess_instrument.instrument.evaluation.assignature.nombre
        nivel = @proccess_instrument.instrument.evaluation.level.nombre
        letra = @proccess_instrument.grade.try(:letra)
        colegio = @proccess_instrument.proccess.order.school.nombre
        name = "#{@proccess_instrument.id}_"+"Análisis"+'_'+proceso+'_'+asignatura+'_'+nivel+'_'+letra+'_'+colegio
        file_name = name.gsub(" ", "_")
        begin
            file_url = "https://s3.amazonaws.com/reimagina-develop/pdfs/#{file_name}.pdf"
            Rails.logger.info file_url
            encoded_url = URI.encode(file_url)
            file = open(URI.parse(encoded_url))
            send_file(
              file,
              filename: "#{file_name}.pdf",
              type: "application/pdf"
            )
        rescue Exception => e
            render text: 'Archivo no encontrado, pruebe utilizando la opción re-generar informe'
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
        @tabla_indicador_title = "Aprendizaje PME"
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
        @alumno_pme = Result.tabla_promedio_alumno_pme_simce(@proccess_instrument,'pme_ability')
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'pme_ability')
        @resumen_estado_title = 'HABILIDAD - INDICADOR'
      end

      def set_report_g
        @tabla_indicador_title = "Habilidad PME"
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
        @alumno_pme = Result.tabla_promedio_alumno_pme_simce(@proccess_instrument,'pme_ability')
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'pme_ability')
        @resumen_estado_title = 'HABILIDAD - INDICADOR'
      end

      def set_report_h
        @tabla_indicador_title = "Habilidad PME"
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
        @alumno_pme = Result.tabla_promedio_alumno_pme_psu(@proccess_instrument,'content')
        @categories_heatmap = Result.categories_heatmap(@proccess_instrument,'content')
        @resumen_estado_title = 'CONTENIDO'
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
        tipo = @instrument.evaluation.evaluation_type.short_name
        curso = @instrument.evaluation.level.short_name
        asignatura = @instrument.evaluation.assignature.try(:short_name)
        # @letter = if tipo == 'psu'
        #                   'h'
        #                 elsif tipo == 'unidad'
        #                   'b'
        #                 elsif tipo == 'simce'
        #                   curso.include?('_b') ? 'f' : 'g'
        #                 elsif tipo == 'nivel'
        #                   if curso.include? '_b'
        #                     asignatura == 'hgcs' && (curso == 'octavo_b' || curso == 'septimo_b') ? 'c' : 'b'
        #                   else
        #                     'd'
        #                   end
        #                 end

            @letter = 'b'

            #ESTO ESTABA OK, TOCA MODIFICAR EN EL FUTURO
            # if tipo == 'nivel' && curso.include?('_b')
            #   if asignatura == 'hgcs' && (curso == 'octavo_b' || curso == 'septimo_b')
            #     @letter = 'b'
            #   else
            #     @letter = 'b'
            #   end
            # end

            # if tipo == 'nivel' && curso.include?('_m')
            #   if asignatura == 'cn' 
            #     @letter = 'b'
            #   elsif asignatura == 'hgcs' 
            #     @letter = 'b'        
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

      private
        def set_admin_menu
          if current_user.has_school_client_role?
            @school_client_menu = true
          else
            @admin_menu = true
          end
        end

        def set_instrument
          @proccess_instrument = ProccessInstrument.find(params[:id])
          @instrument = @proccess_instrument.instrument
          #raise exception if client tries to download evaluations outside its scope changing the URL
          auth = 0
            if current_user.has_school_client_role?
              current_user.assigned_schools.each do |ass|
                if @proccess_instrument.proccess.order.school.id == ass.school_id
                  auth = 1
                end
              end
              if auth == 0
                raise 'acceso denegado'
              end
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