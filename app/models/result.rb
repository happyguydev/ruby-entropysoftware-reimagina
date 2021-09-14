  class Result < ActiveRecord::Base
    def self.student_results(students,answers,guides)
      student_results = []
      #students = students.order(:apellido)
      students = students.order(:apellido, :nombre, :rut)
      students.each do |s|
        answers_student = answers.where(student: s)
        correctas = 0
        # answers_student.each do |as|
        #   if guides.where(question_id: as.question.id).first.try(:alternative_index) == as.letra
        #     correctas+=1
        #   end
        # end
        correctas = answers_student.where(:correct => true).count
        student_results << { student_id: s.id, correctas: correctas }
      end
      student_results
    end

    def self.set_colors(student_results,students,p_instrumento,total_preguntas,pme,hab)
      instrumento = p_instrumento.instrument
      color_bars = []
      stu_color = 'asdf'
      student_results.each do |s|
        student = students.find(s[:student_id])
        if pme.present?
          porcentaje = (self.cantidad_correctas_alumno_indicador(p_instrumento,student,pme,hab)*100)/instrumento.evaluation.questions.where(hab.intern => pme).count
        else
          porcentaje = s[:correctas] > 0 ? ((s[:correctas] / total_preguntas.to_f)*100).round : 0
        end
        puntaje_simce = porcentaje
        if instrumento.evaluation.evaluation_type.short_name == 'simce'
          #porcentaje = ((((porcentaje*2.05+156))/361)*100).round
          porcentaje = puntaje_simce
        end
        puntaje = porcentaje
         if instrumento.evaluation.evaluation_type.short_name == 'simce'
          puntaje = self.to_simce(puntaje_simce,instrumento)
          porcentaje = puntaje
         end

        self.color_ranges(instrumento).each do |c|
          if (c.min..c.max).include?(puntaje)
            stu_color = c.color
          end
        end
        color_bars << [porcentaje,  stu_color, student.nombre+' '+student.apellido]
      end
      return color_bars.sort_by{ |val| val[0] }.reverse
    end

    def self.promedio_curso(instrumento,results,total_preguntas,asistencia)
      logros = []
      suma_correctas = results.map {|sr| sr[:correctas] > 0 ? ((sr[:correctas] / total_preguntas.to_f)*100).round.to_i : 0}


      if asistencia > 0
        promed_curso = (suma_correctas.reduce(:+) / asistencia.to_f).round if suma_correctas
        promedio = promed_curso
        if instrumento.evaluation.evaluation_type.short_name == 'simce'
          promedio = self.to_simce(promed_curso,instrumento)
        end
      else
        promed_curso = 0
      end

      nivel_logro_curso = ""
      self.color_ranges(instrumento).each do |c|
        if (c.min..c.max).include?(promedio)
          nivel_logro_curso = c.nombre
        end
      end
      logros = [promed_curso,nivel_logro_curso]
      logros
    end

    def self.analisis_habilidad(indicador,p_instrumento,asistencia)
      clase = indicador.classify.constantize
      simbolo = indicador+'_id'
      instrumento = p_instrumento.instrument
      pme_abilities = clase.includes(questions: {evaluations: :instruments}).where(instruments: {id: instrumento.id})
      pme_table = []
      pme_abilities.find_each do |pmea|
        nombre_pmea = pmea.nombre.try(:mb_chars).try(:upcase).to_s
        cantidad_preguntas = instrumento.evaluation.questions.where(simbolo.intern => pmea.id).count
        ccpme = cantidad_correctas_habilidad(simbolo,p_instrumento,pmea)
        porcentaje = asistencia > 0 ? (ccpme/(cantidad_preguntas*asistencia.to_f)*100).round.to_i : 0
        pme_table << { nombre_pme: nombre_pmea, cantidad_preguntas: cantidad_preguntas, porcentaje: porcentaje }
      end
      pme_table
    end

    def self.general_oas(p_instrumento,asistencia)
      instrumento = p_instrumento.instrument
      pme_abilities = instrumento.evaluation.questions.map{|q| q.learning_goals.first}.uniq
      pme_table = []
      pme_abilities.each do |pmea|
        nombre_pmea = pmea.nombre.try(:mb_chars).try(:upcase).to_s
        if pmea.level != instrumento.evaluation.level
          nombre_pmea = "#{nombre_pmea}*"
        end
        cantidad_preguntas = instrumento.evaluation.questions.select{|q| q.learning_goals.first.id == pmea.id }.count
        ccpme = cantidad_correctas_oa(p_instrumento,pmea)
        porcentaje = asistencia > 0 ? (ccpme/(cantidad_preguntas*asistencia.to_f)*100).round.to_i : 0
        pme_table << { nombre_pme: nombre_pmea, cantidad_preguntas: cantidad_preguntas, porcentaje: porcentaje }
      end
      pme_table
    end

    def self.cantidad_correctas_oa(p_instrumento,pme)
      instrumento = p_instrumento.instrument
      preg = instrumento.evaluation.questions.map{|q| q if q.learning_goals.first == pme }.compact
      correctas = 0
      preg.each do |p|
        correctas += Answer.where(question_id: p.id, proccess_instrument: p_instrumento, letra: p_instrumento.instrument.guides.find_by(question_id: p.id).try(:alternative_index)).count
      end
      correctas
    end

    def self.cantidad_correctas_habilidad(simbolo,p_instrumento,pme)
      preg = p_instrumento.instrument.evaluation.questions.where(simbolo.intern => pme.id)
      correctas = 0
      preg.find_each do |p|
        correctas += Answer.where(question_id: p.id, proccess_instrument: p_instrumento, letra: p_instrumento.instrument.guides.find_by(question_id: p.id).try(:alternative_index)).count
      end
      correctas
    end

    def self.cantidad_correctas_pme_contenido(p_instrumento,pme,content,hab,cont)
      instrumento = p_instrumento.instrument
      if cont == 'learning_goal'
        preg = instrumento.evaluation.questions.map{|q| q if q.instance_eval(hab+'_id') == pme.id && q.learning_goals.where(id: content.id).present? }.compact
      else
         preg = instrumento.evaluation.questions.map{|q| q if q.instance_eval(hab+'_id') == pme.id && q.instance_eval(cont+'_id') == content.id }.compact
      end
      correctas = 0
      preg.each do |p|
        correctas+= Answer.where(question_id: p.id, proccess_instrument_id: p_instrumento.id).where(:correct => true).count
        # Answer.where(question_id: p.id, proccess_instrument_id: p_instrumento.id).each do |a|
          # if a.letra == instrumento.guides.find_by(question_id: p.id).alternative_index
          #   correctas+=1
          # end
        #end
      end
      correctas
    end


    def self.tabla_logro_habilidad(p_instrumento,asistencia,sufix,indicador)
      simbolo = indicador+'_id'
      habilidad = indicador.intern
      #tabla que entrega un array de hashes formato [{:nombre => "Alto", :color => #12345, :data => [20,25,30]}]
      #para llenar garfico barCombined
      instrumento = p_instrumento.instrument
      pme = instrumento.evaluation.questions.includes(habilidad).map{|q| q.instance_eval(indicador)}.uniq
      alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
      tots_array = []
      tots_hash = []
      #Por cada rango agregamos 1 hash al array
      #count dice cuantos alumnos sacaron cada rango segun su % de acierto en cada habilidad
      self.color_ranges(instrumento).each do |cr|
        pme.each do |ha|
          count = 0
          alumnos.each do |st|
            porcentaje = (self.cantidad_correctas_alumno_indicador(p_instrumento,st,ha,indicador)*100)/instrumento.evaluation.questions.where(simbolo.intern => ha).count
            puntaje = porcentaje
            if instrumento.evaluation.evaluation_type.short_name == 'simce'
              puntaje = self.to_simce(porcentaje,instrumento)
            end
            if (cr.min..cr.max).include?(puntaje)
              count = count + 1
            end
          end
          #calculamos a que % del total de alumnos equivale count
          porcentaje_rango = (count*100)/asistencia
          #llenamos el array chico del key "data"
          tots_array.push(porcentaje_rango)
        end
        if instrumento.evaluation.evaluation_type.short_name == 'simce'
          tots_hash << {nombre: cr.nombre+" - "+self.to_porcentaje(cr.min,instrumento).to_s+sufix+" - "+self.to_porcentaje(cr.max,instrumento).to_s+sufix+sufix, color: cr.color, data: tots_array}
        else
          tots_hash << {nombre: cr.nombre+" - "+cr.min.to_s+sufix+" - "+cr.max.to_s+sufix, color: cr.color, data: tots_array}
        end
        tots_array = []
      end
      tots_hash
    end

    def self.tabla_logro_rangos(p_instrumento,ausentes,indicador)
      clase = indicador.classify.constantize
      simbolo = indicador+'_id'
      habilidad = indicador.intern
      #tabla que entrega un array formato [["Nombre PME", ausentes, pme1,pme2,pme...]]
      #para llenar tabla de logro con colspan
      instrumento = p_instrumento.instrument
      #pme = instrumento.evaluation.questions.includes(:pme_ability).map{|q| q.pme_ability}.uniq
      #pme = clase.includes(questions: {evaluations: :instruments}).where(instruments: {id: instrumento.id}).order("questions.assignature_ability_id")
      pme = clase.includes(questions: {evaluations: :instruments}).where(instruments: {id: instrumento.id}).order("questions.#{simbolo}")
      alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
      tots_array = []
      tots_hash = []
      #Por cada habilidad agregamos 1 array al array
      #count dice cuantos alumnos sacaron cada rango segun su % de acierto en cada habilidad
      pme.each do |ha|
        #inicializamos cada array chico con el nombre de la habilidad y el numero de ausentes
        tots_array.push(ha.nombre,ausentes)
        self.color_ranges(instrumento).order(:min).each do |cr|
          count = 0
          alumnos.each do |st|
            porcentaje = (cantidad_correctas_alumno_indicador(p_instrumento,st,ha,indicador)*100)/instrumento.evaluation.questions.where(simbolo.intern => ha).count
            if instrumento.evaluation.evaluation_type.short_name == 'simce'
              porcentaje = self.to_simce(porcentaje,instrumento)
            end
            if (cr.min..cr.max).include?(porcentaje)
              count = count + 1
            end
          end
          #llenamos el array chico con el valor de count de cada rango
          tots_array.push(count)
        end
        #metemos cada array chico en el array grande
        tots_hash.push(tots_array)
        tots_array = []
      end
      tots_hash
    end

    def self.extra_column(instrumento,hab,cont)
      clase = hab.classify.constantize
      clasecont = cont.classify.constantize
      pme = clase.includes(questions: {evaluations: :instruments}).where(instruments: {id: instrumento.id}).order("questions."+cont+"_id").group(cont+"_id").count
      columna_extra = []
      pme.each do |key,value|
        nombre = clasecont.find(key.to_i).nombre
        columna_extra << {nombre: nombre, rowspan: value}
      end
      columna_extra
    end

    def self.habilidad_contenido_pme(p_instrumento,asistencia,hab,cont)
      #saco habilidades PME presentes en la evaluacion
      clase = cont.classify.constantize
      idclase = (cont.pluralize)+'.id'
      instrumento = p_instrumento.instrument
      pmes = instrumento.evaluation.questions.map{ |q| q.instance_eval(hab) }.uniq
      pme_content_table = []
      pmes.each do |pm|
        pme_parcial = []
        #query que entrega contenido -> cantidad de preguntas de cierta habilidad pme
        if cont == 'learning_goal'
          p = instrumento.evaluation.questions.where(hab.intern => pm.id)
          preguntas_pme = LearningQuestion.joins(:question,:learning_goal).where(question_id: p).group("learning_goal_id").count
        else
          preguntas_pme = instrumento.evaluation.questions.where(hab.intern => pm.id).joins(cont.intern).group(idclase).count
        end
        #recorro el arreglo para agregarle a cada fila el % de correctas
        preguntas_pme.each do |key,value|
          contenido = clase.find(key.to_i)
          cc = self.cantidad_correctas_pme_contenido(p_instrumento,pm,contenido,hab,cont)
          porcentaje = asistencia > 0 ? (cc/(value*asistencia.to_f)*100).round.to_i : 0
            contenido_nombre = contenido.nombre

            if clase == LearningGoal
              if contenido.level != instrumento.evaluation.level
                contenido_nombre = "#{contenido.nombre}*"
              end
            end

          pme_parcial << {nombre_pme: pm.nombre, nombre_contenido: contenido_nombre, cantidad_preguntas: value, porcentaje: porcentaje }
        end
        pme_content_table << pme_parcial
      end
      pme_content_table
    end

    def self.pme_oa(p_instrumento,asistencia,hab,cont,oa)
      instrumento = p_instrumento.instrument
      pme_oa_table = []
      #pme_oa_table = pme_oa_table << {num: 'N', pme: 'Hab PME', contenido: 'Contenido', oa: 'OA',lograron: 'Lograron', no_lograron: 'No Lograron'}
      guia = Guide.where(:instrument => instrumento).order(:question_index)
      guia.each do |g|
        p = g.question
        lograron = cantidad_correctas(p_instrumento,p)
        no_lograron = asistencia - lograron
        pme = p.instance_eval(hab).nombre
        contenido = p.instance_eval(cont).try(:nombre)
        if (oa == 'learning_goal')
          lg = p.try(:learning_goals).try(:map){|oa| oa.try(:nombre)}.try(:sort).try(:join, ("-"))
          if p.learning_goals.last.level != instrumento.evaluation.level
            lg = "#{lg}*"
          end
        else
          lg = p.instance_eval(oa).try(:nombre)
        end
        index = g.question_index
        pme_oa_table << {num: index, pme: pme, contenido: contenido, oa: lg,lograron: lograron, no_lograron: no_lograron}
      end
      pme_oa_table
    end

    def self.glosario(instrumento,indicador)
       oas = []
       oas_glosario = []
       instrumento.evaluation.questions.each do  |q|
        q.learning_goals.each do  |lg|
          oas << lg.id         
        end
       end 
      
       joined = LearningGoalsUnit.joins(:learning_goal).where(:learning_goal_id => oas).order('learning_goals.nombre')

       joined.each do |oa|
        nombre_oa = oa.learning_goal.nombre
        if oa.learning_goal.level != instrumento.evaluation.level
          nombre_oa = "#{nombre_oa}*"
        end
        oas_glosario << {unidad: oa.unit.numero, descripcion: oa.description, nombre: nombre_oa}
       end
       oas_glosario
    end

    def self.remediales(instrumento)
      remediales_table = []
      guia = Guide.where(:instrument => instrumento).order(:question_index)
      guia.each do |g|
        index = g.question_index
        contenido = g.question.content
        remedial = g.question.advice.name || "Sin remediales disponibles"
        remediales_table << {num: index, contenido: contenido.nombre, remedial: remedial }
      end
      remediales_table
    end
    
    def self.tabla_logro_totales(p_instrumento,student_results, ausentes)
      instrumento = p_instrumento.instrument
      #tabla que entrega un array formato [10,20,30,40] total alumnos de cada rango
      #para llenar tabla con totales abajo del grafico
      pme = instrumento.evaluation.questions.map{|q| q.pme_ability}.uniq
      alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
      tots_array = []
      tots_array.push(ausentes)
      self.color_ranges(instrumento).order(:min).each do |cr|
        count = 0
        student_results.each do |st|
          porcentaje = ((st[:correctas]*100)/instrumento.evaluation.questions.count).round
          if instrumento.evaluation.evaluation_type.short_name == 'simce'
            porcentaje = self.to_simce(porcentaje,instrumento)
          end
          if (cr.min..cr.max).include?(porcentaje)
            count = count + 1
          end
        end
        #llenamos el array chico con el valor de count de cada rango
        tots_array.push(count)
      end
      tots_array
    end

    def self.logro_alumno_oa(p_instrumento,hab,student_results,total_preguntas)
      #generar tabla con headers por separado, formato
      #headers : ['nombre','oa1','oa2','promedio simce','logro total']
      #body : [['pepe',25,25,25,25,25],['juana',25,25,25,25],etc]
      instrumento = p_instrumento.instrument
      #construyendo headers
      headers = []
      tabla_parcial = []
      tabla_prom_pme = []
      #pluralizar cuando hab = learning_goal
      #comentamos linea de habilidad 1:n por si algun dia recibo algo que no es learning_goal
      #headers = instrumento.evaluation.questions.map{|q| q.instance_eval(hab).nombre}.uniq
      #headers = instrumento.evaluation.questions.map{|q| q.learning_goals.map{|oa| oa.nombre}[0]}.uniq
      objetivos = instrumento.evaluation.questions.map{|q| q.learning_goals.map{|oa| oa.id}[0]}.uniq
      objetivos.each do |obj|
        oa = LearningGoal.find(obj)
        if oa.level == instrumento.evaluation.level
          headers.push(oa.nombre)
        else
          headers.push("#{oa.nombre}*")
        end

      end
      headers.unshift("<b>Nombre</b>".html_safe)
      headers.push("<b>Logro Total</b>".html_safe)
      #construyendo body
      #comentamos linea de habilidad 1:n por si algun dia recibo algo que no es learning_goal
      # pme = instrumento.evaluation.questions.map{|q| q.instance_eval(hab)}.uniq
      #pme = instrumento.evaluation.questions.map{|q| q.learning_goals.map{|oa| oa}}.uniq.first
      pme = instrumento.evaluation.questions.map{|q| q.learning_goals.first}.uniq
      alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
      alumnos.each_with_index do |al,i|
        acum_parcial = 0
        full_name = al.nombre+' '+al.apellido
        tabla_parcial.push(full_name)
        pme.each_with_index do |pm,k|
          porcentaje = ((cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)*100)/LearningQuestion.where(question: instrumento.evaluation.questions).where(learning_goal_id: pm.id).count).round
          tabla_parcial.push(porcentaje.to_s+'%')
          acum_parcial += porcentaje
        end
        #tabla_parcial.push(((acum_parcial/pme.count.to_f)*2.05+156).round)
        #tabla_parcial.push((acum_parcial/pme.count.to_f).round.to_s+'%')
        prom_gral = student_results[i][:correctas] > 0 ? ((student_results[i][:correctas] / total_preguntas.to_f)*100).round : 0        
        tabla_parcial.push(prom_gral.to_s+'%')
        
        tabla_prom_pme.push(tabla_parcial)
        tabla_parcial = []
      end
      [headers,tabla_prom_pme]
    end


    def self.tabla_promedio_alumno_pme(p_instrumento,hab)
      instrumento = p_instrumento.instrument
      tabla_prom_pme = []
      pme = instrumento.evaluation.questions.map{|q| q.instance_eval(hab)}.uniq
      alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
      pme.each_with_index do |pm,i|
        acum_parcial = 0
        acum_parcial_correctas = 0
        acum_parcial_preguntas = 0
        alumnos.each_with_index do |al,k|
          porcentaje = ((cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)*100)/(instrumento.evaluation.questions.where(hab.intern => pm).count).to_f).round
          tabla_prom_pme.push([i,k,porcentaje.to_s+"%",get_color(instrumento,porcentaje)])
          acum_parcial += porcentaje
          acum_parcial_correctas = cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
          acum_parcial_preguntas = instrumento.evaluation.questions.where(hab.intern => pm).count
        end
        tabla_prom_pme.push([i,alumnos.count,(acum_parcial/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_parcial/alumnos.count.to_f).round)])
       
        if instrumento.evaluation.evaluation_type.short_name == 'simce'
          tabla_prom_pme.push([i,alumnos.count+1,((acum_parcial/alumnos.count.to_f)*2.05+156).round,get_color(instrumento,((acum_parcial/alumnos.count.to_f)*2.05+156).round)])
        end
       
        if instrumento.evaluation.evaluation_type.short_name == 'psu'
          tabla_prom_pme.push([i,alumnos.count+1,self.to_psu(acum_parcial_correctas,acum_parcial_preguntas),get_color(instrumento,self.to_psu(acum_parcial_correctas,acum_parcial_preguntas))])
        end

      end
      #se agregan los promedios
      acum_total = 0
      acum_correctas = 0
      acum_preguntas = 0
      alumnos.each_with_index do |al,i|
        promedio = 0
        cant_correctas = 0
        cant_preguntas = 0
        pme.each do |pm|
          cant_correctas = cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
          cant_preguntas = instrumento.evaluation.questions.where(hab.intern => pm).count
          promedio += (cant_correctas*100/cant_preguntas.to_f).round
        end
        tabla_prom_pme.push([pme.count,i,(promedio/pme.count.to_f).round.to_s+"%",get_color(instrumento,(promedio/pme.count.to_f).round)])#
        acum_total += (promedio/pme.count.to_f).round#
        acum_correctas += cant_correctas
        acum_preguntas += cant_preguntas
        if instrumento.evaluation.evaluation_type.short_name == 'simce'
          promedio_simce = ((promedio/pme.count.to_f)*2.05+156).round
          tabla_prom_pme.push([pme.count+1,i,(promedio_simce).round,get_color(instrumento,(promedio_simce).round)])
        end
        if instrumento.evaluation.evaluation_type.short_name == 'psu'
          promedio_simce = self.to_psu(cant_correctas,cant_preguntas)
          tabla_prom_pme.push([pme.count+1,i,(promedio_simce).round,get_color(instrumento,(promedio_simce).round)])
        end
    end
    tabla_prom_pme.push([pme.count,alumnos.count,(acum_total/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_total/alumnos.count.to_f).round)])#
    if instrumento.evaluation.evaluation_type.short_name == 'simce'
      acum_simce = (acum_total/alumnos.count.to_f)*2.05+156
      tabla_prom_pme.push([pme.count+1,alumnos.count,(acum_simce).round,get_color(instrumento,(acum_simce).round)])
    end
    if instrumento.evaluation.evaluation_type.short_name == 'psu'
      acum_simce = self.to_psu(acum_correctas,acum_preguntas)
      tabla_prom_pme.push([pme.count+1,alumnos.count,(acum_simce).round,get_color(instrumento,(acum_simce).round)])
    end
    tabla_prom_pme
  end

  def self.tabla_promedio_alumno_pme_simce(p_instrumento,hab,student_results,total_preguntas)
    instrumento = p_instrumento.instrument
    tabla_prom_pme = []
    pme = instrumento.evaluation.questions.map{|q| q.instance_eval(hab)}.uniq
    alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
    pme.each_with_index do |pm,i|
      acum_parcial_simce = 0
      acum_parcial = 0
      acum_parcial_correctas = 0
      acum_parcial_preguntas = 0
      alumnos.each_with_index do |al,k|
        porcentaje = ((cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)*100)/(instrumento.evaluation.questions.where(hab.intern => pm).count).to_f).round
        porcentaje_simce = porcentaje
        #porcentaje == 0 ? porcentaje_simce = 0 : porcentaje_simce = ((((porcentaje*2.05+156))/361)*100).round     
        tabla_prom_pme.push([i,k,porcentaje_simce.to_s+"%",get_color(instrumento,porcentaje)])
        acum_parcial += porcentaje
        acum_parcial_simce += porcentaje_simce
        acum_parcial_correctas = cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
        acum_parcial_preguntas = instrumento.evaluation.questions.where(hab.intern => pm).count
      end
      #elimino columna promedio logro
      tabla_prom_pme.push([i,alumnos.count,(acum_parcial_simce/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_parcial_simce/alumnos.count.to_f).round)])
      tabla_prom_pme.push([i,alumnos.count+1,((acum_parcial/alumnos.count.to_f)*2.05+156).round,get_color(instrumento,((acum_parcial/alumnos.count.to_f)*2.05+156).round)])
      #tabla_prom_pme.push([i,alumnos.count+1,"x",get_color(instrumento,((acum_parcial/alumnos.count.to_f)*2.05+156).round)])
    end
    #se agregan los promedios
    acum_total = 0
    acum_correctas = 0
    acum_preguntas = 0
    acum_prom_simce = 0
    acum_prom_general = 0
    alumnos.each_with_index do |al,i|
      promedio = 0
      cant_correctas = 0
      cant_preguntas = 0
      pme.each do |pm|
        cant_correctas = cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
        cant_preguntas = instrumento.evaluation.questions.where(hab.intern => pm).count
        if cant_correctas > 0 
          #promedio += (((((cant_correctas*100/cant_preguntas.to_f).round*2.05+156))/361)*100).round
          promedio += (cant_correctas*100/cant_preguntas.to_f).round
        end
      #promedio_simce_gral += (cant_correctas*100/cant_preguntas.to_f).round              
      end
      #tabla_prom_pme.push([pme.count,i,(promedio/pme.count.to_f).round.to_s+"%",get_color(instrumento,(promedio/pme.count.to_f).round)])
      
      #elimino tabla prom pme %
      #tabla_prom_pme.push([pme.count,i,(promedio/pme.count.to_f).round.to_s+"%",get_color(instrumento,(promedio/pme.count.to_f).round)])
      acum_total += (promedio/pme.count.to_f).round
      acum_correctas += cant_correctas
      acum_preguntas += cant_preguntas
      #promedio en pts simce en base a logro total del alumno
      prom_gral = student_results[i][:correctas] > 0 ? ((student_results[i][:correctas] / total_preguntas.to_f)*100).round : 0
      promedio_simce = prom_gral*2.05+156
      #promedio_simce = prom_gral
      acum_prom_simce += promedio_simce.round
      acum_prom_general += prom_gral
      tabla_prom_pme.push([pme.count+1,i,(promedio_simce).round,get_color(instrumento,(promedio_simce).round)])

  end
      #elimino columna promedio logro
      #tabla_prom_pme.push([pme.count,alumnos.count,(acum_total/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_total/alumnos.count.to_f).round)])
      #acum_simce = (acum_prom_simce/alumnos.count.to_f)
      acum_simce = (acum_prom_general/alumnos.count.to_f).round*2.05+156
      tabla_prom_pme.push([pme.count+1,alumnos.count,(acum_simce).round,get_color(instrumento,(acum_simce).round)])

  tabla_prom_pme
end

def self.tabla_promedio_alumno_pme_psu(p_instrumento,hab,student_results,total_preguntas)
  #formula (600/X)*Y+250 X = cant preguntas, Y = cant correctas
  #total = (600/cant_preguntas)*cant_correctas+250
  instrumento = p_instrumento.instrument
  tabla_prom_pme = []
  pme = instrumento.evaluation.questions.map{|q| q.instance_eval(hab)}.uniq
  alumnos = p_instrumento.answers.includes(:student).order('students.apellido, students.nombre, students.rut').map{|a| a.student}.uniq
  pme.each_with_index do |pm,i|
    acum_parcial_psu = 0
    acum_parcial = 0
    acum_parcial_correctas = 0
    acum_parcial_preguntas = 0
    alumnos.each_with_index do |al,k|
      porcentaje = ((cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)*100)/(instrumento.evaluation.questions.where(hab.intern => pm).count).to_f).round
      correctas = cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
      total_pregs = instrumento.evaluation.questions.where(hab.intern => pm).count
      porcentaje == 0 ? porcentaje_psu = 0 : porcentaje_psu = (600/total_pregs)*correctas+250    
      tabla_prom_pme.push([i,k,porcentaje.to_s+"%",get_color(instrumento,porcentaje)])
      acum_parcial += porcentaje
      acum_parcial_psu += porcentaje_psu
      acum_parcial_correctas += cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
      acum_parcial_preguntas += instrumento.evaluation.questions.where(hab.intern => pm).count
    end
    #tabla_prom_pme.push([i,alumnos.count,(acum_parcial_psu/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_parcial_psu/alumnos.count.to_f).round)])
    #tabla_prom_pme.push([i,alumnos.count+1,((acum_parcial/alumnos.count.to_f)*2.05+156).round,get_color(instrumento,((acum_parcial/alumnos.count.to_f)*2.05+156).round)])
    tabla_prom_pme.push([i,alumnos.count,(acum_parcial/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_parcial/alumnos.count.to_f).round)])
    tabla_prom_pme.push([i,alumnos.count+1,((acum_parcial_psu/alumnos.count.to_f)).round.to_s,"#ADD8E6"])
  end
  #se agregan los promedios
  acum_total = 0
  acum_correctas = 0
  acum_preguntas = 0
  acum_prom_psu = 0
  alumnos.each_with_index do |al,i|
    promedio = 0
    cant_correctas = 0
    cant_preguntas = 0
    pme.each do |pm|
      cant_correctas = cantidad_correctas_alumno_indicador(p_instrumento,al,pm,hab)
      cant_preguntas = instrumento.evaluation.questions.where(hab.intern => pm).count
      if cant_correctas > 0 
        promedio += (cant_correctas*100/cant_preguntas.to_f).round
      end
    #promedio_simce_gral += (cant_correctas*100/cant_preguntas.to_f).round              
    end
    tabla_prom_pme.push([pme.count,i,(promedio/pme.count.to_f).round.to_s+"%",get_color(instrumento,(promedio/pme.count.to_f).round)])#
    acum_total += (promedio/pme.count.to_f).round#
    acum_correctas += cant_correctas
    acum_preguntas += cant_preguntas
    #promedio en pts PSU en base a logro total del alumno
    prom_gral = student_results[i][:correctas] > 0 ? ((student_results[i][:correctas] / total_preguntas.to_f)*100).round : 0
    #promedio_psu = prom_gral*2.05+156
    #total = (600/cant_preguntas)*cant_correctas+250
    promedio_psu = student_results[i][:correctas] > 0 ? (600/total_preguntas)*student_results[i][:correctas]+250 : 0
    acum_prom_psu += promedio_psu
    tabla_prom_pme.push([pme.count+1,i,(promedio_psu).round.to_s,"#ADD8E6"])
end
    tabla_prom_pme.push([pme.count,alumnos.count,(acum_total/alumnos.count.to_f).round.to_s+"%",get_color(instrumento,(acum_total/alumnos.count.to_f).round)])#
    acum_psu = (acum_prom_psu/alumnos.count.to_f)
    tabla_prom_pme.push([pme.count+1,alumnos.count,(acum_psu).round.to_s,"#ADD8E6"])

tabla_prom_pme
end

    def self.set_sufix(instrumento)
      if instrumento.evaluation.evaluation_type.short_name == 'simce'
        sufix = ''
      else
        sufix = '%'
      end
    end

    def self.categories_heatmap(p_instrumento,hab)
      instrumento = p_instrumento.instrument
      array_categories = []
      xcategories = instrumento.evaluation.questions.map{|q| q.instance_eval(hab).nombre}.push("Promedio Logro".html_safe).uniq
      ycategories = p_instrumento.answers.includes(:student).order('students.apellido').map{|a| a.student.nombre+" "+a.student.apellido}.push("PROMEDIO".html_safe).uniq
      if instrumento.evaluation.evaluation_type.short_name == 'simce'
        ycategories.push("<b>Ponderación SG</b>".html_safe)
        xcategories.pop()
        xcategories.push("<b>Pond. SG</b>".html_safe)
      end

      if instrumento.evaluation.evaluation_type.short_name == 'psu'
        ycategories.push("Puntaje PSU".html_safe)
        xcategories.push("Ptje. PSU".html_safe)
      end
      [xcategories,ycategories]
    end

    def self.abilities(instrumento,hab)
      abilities = instrumento.evaluation.questions.map{|q| q.instance_eval(hab) }.uniq
      abilities
    end

    def self.cantidad_correctas_alumno_indicador(p_instrumento,alumno,pme,hab)
      habid = hab+'_id'
      instrumento = p_instrumento.instrument

      if hab == 'learning_goal'
          preg = instrumento.evaluation.questions.map{|q| q if q.learning_goals.where(id: pme.id).present? }.compact
      else
          preg = instrumento.evaluation.questions.where(habid.intern => pme.id)
      end


      correctas = 0
       preg.each do |p|
         correctas += Answer.where(student_id: alumno.id).where(question_id: p.id, proccess_instrument: p_instrumento).where(:correct => true).count
       end
      correctas
    end

    def self.cantidad_correctas(p_instrumento,question)
      instrumento = p_instrumento.instrument
      correctas = 0
      correctas =  Answer.where(question_id: question.id, proccess_instrument: p_instrumento).where(:correct => true).count
      correctas
    end


    def self.color_set
      [
        "#5DA5DA",
        "#FAA43A",
        "#60BD68",
        "#B2912F",
        "#B276B2",
        "#DECF3F",
        "#664D85",
        "#3F92A9",
        "#D37F3A",
        "#4B7BB4",
        "#B34441",
        "#94B255",
        "#7A5F9A",
        "#47A4BD",
        "#EC8F42",
        "#7596C6",
        "#D69897",
        "#A9C379",
        "#937FAD",
        "#70B7CD",
        "#FABF99",
        "#A1B4D4",
        "#D29998",
        "#C0D2A4",
        "#B3A8C4",
        "#98C6D6",
        "#F9BE9E",
        "#A1B4D4",
        "#D29998",
        "#C0D2A4",
        "#B3A8C4",
        "#98C6D6",
        "#F9BE9E",
        "#A1B4D4",
        "#D29998",
        "#C0D2A4",
        "#B3A8C4",
        "#98C6D6",
        "#F9BE9E",
        "#71893F",
        "#5C4776",
        "#357D91",
        "#B66D31",
        "#426DA1",
        "#A44340",
        "#849F4B",
        "#664D85",
        "#3F92A9",
        "#D37F3A",
        "#4B7BB4",
        "#B34441",
        "#94B255",
        "#7A5F9A",
        "#47A4BD",
        "#EC8F42",
        "#7596C6",
        "#D69897",
        "#A9C379",
        "#937FAD",
        "#70B7CD"
        ]
    end

    def self.set_stops(instrumento)
      #crea un array tipo [0.5, 'red'] por cada rango
      #en caso de simce/psu hay que pasar los puntajes a % primero
      array_general = []
      array_parcial = []
      colors = ColorRange.
        where(:assignature => instrumento.evaluation.assignature).
        where(:level => instrumento.evaluation.level).
        where(:evaluation_type => instrumento.evaluation.evaluation_type)
      max = colors.order(:max).last.max
      colors.each do |c|
        solid = c.color
        array_parcial = []
        if instrumento.evaluation.evaluation_type.short_name == 'simce'
          maxporcentaje = ((c.max*100)/max)/100
          minporcentaje = ((c.min*100)/max)/100
        else
          maxporcentaje = c.max/100.to_f
          minporcentaje = c.min/100.to_f
        end
        array_parcial.push(minporcentaje,c.color)
        array_general.push(array_parcial)
        array_parcial = []
        array_parcial.push(maxporcentaje,c.color)
        array_general.push(array_parcial)

      end
      array_general.push([1.1,'#FFFFFF'],[1.5,'#FFFFFF'])
      array_general
    end

    def self.to_simce(porcentaje,instrumento)
      total = (porcentaje*2.05+156).to_f.round
      total
    end

    def self.to_psu(cant_correctas,cant_preguntas)
      #formula (600/X)*Y+250 X = cant preguntas, Y = cant correctas
      total = (600/cant_preguntas)*cant_correctas+250
      total
    end

    def self.to_porcentaje(puntaje,instrumento)
      colors = self.color_ranges(instrumento)
      minimo = colors.first.min
      maximo = colors.last.max
      if puntaje == minimo
        total = 0
      else
        total = ((puntaje*100)/maximo).round
      end
      total
    end

    def self.color_ranges(instrumento)
      colors = ColorRange.
        where(:assignature => instrumento.evaluation.assignature).
        where(:level => instrumento.evaluation.level).
        where(:evaluation_type => instrumento.evaluation.evaluation_type)
      colors.order(:min)
    end

    def self.get_color(instrumento,range)
        colors = self.color_ranges(instrumento)
        color = ""
        if instrumento.evaluation.evaluation_type.short_name == 'simce' && range < 101
          range = (range*2.05+156).to_f.round 
        end

        # =(600/X) • X+ 250 donde X= cantidad de respuestas correctas
        if instrumento.evaluation.evaluation_type.short_name == 'psu' && range > 100
          range = (range*100/850).to_f.round 
        end
        colors.each do |c|
          if (c.min..c.max).include?(range)
            color = c.color
          end
        end
        color
    end

    def self.descendidos(pme_oa)
      #metodo que entrega cantidad de correctas maximas que puede tener una pregunta para ser descendida
      #primero ordeno la tabla de preguntas por logro
      #luego tomo los 3 más bajos
      cantidad_correctas = 0
      ultimo = []
      penultimo = []
      antepenultimo = []
      ordenados = pme_oa.sort_by { |que| que[:lograron] }.uniq.first(3)
      ultimo =  pme_oa.select {|log| log[:lograron] == ordenados[0][:lograron] }
      if ordenados.count > 1
        penultimo = pme_oa.select {|log| log[:lograron] == ordenados[1][:lograron] }
      end
      if ordenados.count > 2
        antepenultimo = pme_oa.select {|log| log[:lograron] == ordenados[2][:lograron] }
      end

      #luego pregunto por cada uno si suman 3 preguntas, si no suman 3 preguntas
      #se pasa al siguiente
      if ultimo.count > 2
        cantidad_correctas = ultimo.first[:lograron]
      elsif ultimo.count + penultimo.count > 2
        cantidad_correctas = penultimo.first[:lograron]
      else
        if antepenultimo.first != nil
          cantidad_correctas = antepenultimo.first[:lograron]
        end
      end
      return cantidad_correctas
    end

  end
