module ComparativesHelper
  
    #para daem se necesita :
    #1: Promedio por asignatura por escuela por nivel para tabla "promedio por asignatura/promedio escuela"
    #2: Con los promedios de cada escuela una nueva tabla por escuela por asignatura 
    #Estructura tabla 1 : @school_ass_level[year][school][assignature][level]
    #Estructura tabla 2: (@school_ass_level[year][school][assignature].inject{|sum, el| sum + el }.to_f / avg_ass.size).round
    #Utilizamos los mismos datos de la estructura de la tabla 2 para completar la fila "Promedio escuela de la tabla 1"
  
    ##################### METODOS DAEM CONSOLIDADO ###############################
  
    #METODOS PROMEDIO POR ASIGNATURA s

    #CONSOLIDADO SOSTENEDOR SIMCE FILA PROMEDIO DE COLEGIOS MISMO CURSO/ASIGNATURA
    def comunal_assignature_level year, assignature, level
      #fila promedio escuela
      avg_ass = @school_avrg[year]['comunal'][assignature.id][level.id].try(:flatten).try(:compact)
      #avg_simce = avg_ass.map{|avg| }
      if avg_ass.present?
        score = (avg_ass.inject{|sum, el| sum + el }.to_f / avg_ass.size).round
        #@school_avrg_totals[year][assignature.id]['comunal'] << score if score.present?         
        score.to_s
      else
        'N/D'
      end
    end

    #Estructura tabla 1 : @school_ass_level[year][school][assignature][level]
    def school_assignature_level year, school,assignature,level
      # puts "SCHOOL RESULT"
      # @school_result
      #fila promedio de cada curso
      score = @school_result[year][school][assignature.id][level.id]
      @school_avrg[year]['comunal'][assignature.id][level.id] << score.to_i if score.present?
      score.nil? ? 'N/D' : score.to_s + '%'
    end
    
    def check_school_assignature_level school, year
      @assignatures.each do |a|
        @levels.each do |l|
          if @school_result[year][school][a.id][l.id].present?
            return true
          end
        end
      end
      return false
    end

    def check_school_assignature_per_level school, year, level
      @assignatures.each do |a|
        if @school_result[year][school][a.id][level.id].present?
          return true
        end
      end
      return false
    end

    def assignatures_with_score year, level
      full_assignatures = []
      @assignatures.each do |a|
        @for_school.each do |school|
          if @school_result[year][school][a.id][level.id].present?
            full_assignatures << a
          end
        end
      end

      return full_assignatures.uniq

    end

    def check_school_pme_ability school, year, assignature, level
      get_assignature_level_pme_abilities(assignature.id, level.id) do |pme_ability|
          if @school_result_pme_abilities[school][year][assignature.id][level.id][pme_ability.id].present?
            return true
          end
        end
      return false
    end

    #Estructura tabla 2: 
    #avg_ass = @school_ass_avg[year][school][assignature]
    #(avg_ass.inject{|sum, el| sum + el }.to_f / avg_ass.size).round
  
    def school_assignature_avg school, year, assignature
      #fila promedio escuela
      avg_ass = @school_avrg[year][school][assignature.id].try(:flatten).try(:compact)
      if avg_ass.present?
        score = (avg_ass.inject{|sum, el| sum + el }.to_f / avg_ass.size).round
        #@school_avrg_totals[year][assignature.id] << score if score.present?         
        score.to_s + '%'
      else
        'N/D'
      end
    end
    
    def school_assignature_totals year, assignature
      #fila "Promedio Comunal"
      school_avg = @school_avrg_totals[year][assignature.id].try(:flatten).try(:compact)    
      if school_avg.present?
        (school_avg.inject{|sum, el| sum + el }.to_f / school_avg.size).round.to_s + '%'
       else
         'N/D'
       end
    end
  
  
    #METODOS HABILIDAD PME
    def school_pme_ability_avg school, year, assignature, level
      #columna "promedio curso % logro"
      if @school_avg_pme_level[school][year][assignature.id][level.id].try(:flatten).try(:compact).present?
        (@school_avg_pme_level[school][year][assignature.id][level.id].try(:flatten).try(:compact).try(:sum).to_f/@school_avg_pme_level[school][year][assignature.id][level.id].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
    
    def school_average_per_pme_ability assignature_id, pme_ability_id, year, level_id
      #puts "FILA TOTALES"
      if @school_avg_pme_ability_totals[year][assignature_id][level_id][pme_ability_id].try(:compact).present?
        score = (@school_avg_pme_ability_totals[year][assignature_id][level_id][pme_ability_id].try(:compact).try(:sum)/@school_avg_pme_ability_totals[year][assignature_id][level_id][pme_ability_id].try(:compact).try(:count))
        @school_avg_pme_ability_totals[year][assignature_id][level_id]['avg'] << score if score.present?      
        score.to_s + '%'
      else
        'N/D'
      end
    end

    def school_average_per_pme_ability_proc assignature_id, pme_ability_id, year, school
      #puts "FILA TOTALES"
      if @school_avg_pme_proc[school][year][assignature_id][pme_ability_id].try(:compact).present?
        score = (@school_avg_pme_proc[school][year][assignature_id][pme_ability_id].try(:compact).try(:sum)/@school_avg_pme_proc[school][year][assignature_id][pme_ability_id].try(:compact).try(:count).to_f).round
        score.to_s + '%'
      else
        'N/D'
      end
    end
  

    #@school_result_pme_abilities[school][year][assignature.id][level.id][ability.id]

    def school_last_avg_pme_abilities assignature_id, year, level_id
      #puts "ULTIMA CELDA"
      if @school_avg_pme_ability_totals[year][assignature_id][level_id]['avg'].try(:compact).present?
        (@school_avg_pme_ability_totals[year][assignature_id][level_id]['avg'].try(:compact).try(:sum).to_f/@school_avg_pme_ability_totals[year][assignature_id][level_id]['avg'].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
  
    def school_pme_ability_score_n_average school, year, assignature, level, pme_ability
      score = @school_result_pme_abilities[school][year][assignature.id][level.id][pme_ability.id]
  
      @school_avg_pme_level[school][year][assignature.id][level.id] << score.to_i if score.present? 
      @school_avg_pme_ability_totals[year][assignature.id][level.id][pme_ability.id] << score.to_i if score.present?
      
      if(school.class.name != 'School')
        @school_avg_pme_proc[school][year][assignature.id][pme_ability.id] << score.to_i if score.present?
      end
      score.nil? ? 'N/D' : score.to_s + '%' 
  end
  
    def daem_school_grouped_by_level school,year, level
      #get present levels
      #level_ids = @levels.collect(&:id)
      #@for_school.last.grades.where(year: year).sort_by(&:level_id).group_by(&:level_id)
      #school.grades.where(year: year, level_id: level.id).sort_by(&:level_id).group_by(&:level_id)
      #agrego last para hacer analisis total y no por letra
      school.grades.where(year: year, level_id: level.id).sort_by(&:level_id).group_by(&:level_id)
      
    end
  
    def school_group_students_with_their_level grade, assignature, pme_ability, type, year, school
      #aca reemplazar s_answers por el verdadero total de preguntas y no solo las que contesto
      proctype = ProcType.where(nombre: @params['proccess']).last.id
      pme_questions = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': school.id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).reject{ |e| e.level_id != grade.level.id }.uniq.flatten.compact.collect(&:questions).flatten.compact.reject{ |q| q.pme_ability_id != pme_ability.id}.uniq        
      #######################################################################################

      ##########TODO
      #Conseguir listado de alumnos que al menos contestaron 1 pregunta en todas las evaluaciones 
      #de este nivel/asignatura 
      #############

      school_set_student_level_and_range(assignature, grade, school)

      @all_answers =  if type == 'joined'
                        #@school_ans[school][year].where('grades.level_id': grade.level.id,'evaluations.assignature_id': assignature.id)
                        #esta parte falla porque estoy tomando lista de alumnos en base a respuestas de ese ability, si hay 1 pregunta de ability X y la omite
                        #queda ausente siendo que si tiene respuestas en otro esta presente, aca deberia obtener listado de alumnos de todas las evaluaciones
                        #y despues agregar alumnos presentes con todas omitidas de este ability al listado final
                        @school_answers[school][year][assignature.id][grade.level_id][pme_ability.id]
                      else
                        @school_answers[school][year][assignature.id][grade.level_id][pme_ability.id].where('grades.id': grade.id) 
                      end

      # aca saco "id" => [answers], obtengo students que no omitieron nada, les tengo que attachear a los que omitieron todo para que les ponga todo malo
      group_by_students = @all_answers.group_by(&:student_id)
      
      total_students =  if type == 'joined'
        grade.school.grades.where(year: grade.year, level_id: grade.level_id).collect(&:students).flatten.compact.count
      else
        grade.students.count
      end

present_students =  if type == 'joined'
      @school_ans[school][year].where('evaluations.level_id': grade.level.id, 'evaluations.assignature_id': assignature.id ).collect(&:student_id).uniq.count                      
    else
      @school_ans[school][year].where('grades.id': grade.id, 'evaluations.assignature_id': assignature.id ).collect(&:student_id).uniq.count                      
    end

      group_by_students.map do |student,s_answers|
        correct_answers = s_answers.select{ |ans| ans.correct }
        school_calculate_percent_and_level(correct_answers, pme_questions, s_answers.collect(&:question).uniq.count, school)
      end
      
      ##### calculo porcentajes de alumnos omitidos que equivale a : alumos con algo - alumnos con algo en este pme hab
      missing_students = present_students - group_by_students.count

      #por cada alumno que omitio todo de una habilidad corro la funcion como que hubiera contestado todo malo para afectar puntaje 
      missing_students.times { school_calculate_percent_and_level([], pme_questions, 0, school) }
     
                        
      #@student_by_level['absent'] = total_students - group_by_students.keys.count
      @school_student_by_level[school]['absent'] = total_students - present_students
      group_by_students
  end


  #################### METODOS COMPARE REPORT START ########################################################

  def compare_group_students_with_their_level level, assignature, year, proctype
   
    #voy a correr esto 1 vez por proceso/curso/asignatura/nivel
    #en el caso de los comparativos tengo que extraer los rangos por proceso por asignatura por curso
    #luego sacar el % de alumnos en cada rango, y el promedio por rango de todos los procesos
    #1 tabla por asignatura/curso
    #no se consideran los ausentes, la suma de todas las columnas debe dar 100%
    
    #necesito SCHOOL para filtrar las preguntas y PROCESO para almacenarlas donde corresponde
    school = @for_school.last.id

    #el total de preguntas corresponde a todas las de X asignatura X curso
    #aca por ejemplo obtenemos todas las preguntas de 1ro basico lenguaje para el proceso SIMCE 6
    total_questions = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': school ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).reject{ |e| e.level_id != level.id }.reject{ |e| e.assignature_id != assignature.id }.uniq.flatten.compact.collect(&:questions).flatten.compact.uniq
    #aca determino todas las respuestas para X proceso, asignatura y nivel
    #@school_ans[proctype][year].where('evaluations.level_id': grade.level.id, 'evaluations.assignature_id': assignature.id )
    @all_answers =  @school_answers_range[proctype][year][assignature.id][level.id]
    #aca agrupo las respuestas de esa celda por student 
    group_by_students = @all_answers.group_by(&:student_id)
    #aca cuento cuantos alumnos tienen respuesta
    present_students = group_by_students.count                      

    #aca por cada student del grupo selecciono  cuantas correctas tuvo, y en base a las correctas del rango saco score
    group_by_students.map do |student,s_answers|
      correct_answers = s_answers.select{ |ans| ans.correct }
      compare_calculate_percent_and_level(correct_answers, total_questions, s_answers.collect(&:question).uniq.count, proctype, assignature, level)
    end

    # student_amount = @school_student_by_level[proctype][assignature.id][level.id][srip_and_downcase(range.nombre)]
    # student_percent = (student_amount*100/present_students).to_f.round
    # @school_student_by_level[proctype][assignature.id][level.id][srip_and_downcase(range.nombre)] = student_percent

end

def compare_calculate_percent_and_level correct_ans, student_ans, all_quest, school, assignature, level
  ranges = ColorRange.compare_colors(assignature, level, @evaluation_type)
  #calculo el score de ese proceso/level/assignature
  #@sc[simce1][lenguaje][1basico][rango] = X
  #sc[avg][lenguaje][1basico][rango] << x
  score = percent(correct_ans, student_ans)
  if @evaluation_type.short_name == 'simce'
    score = (score*2.05+156).to_f.round
  end
  range = ranges.where('min <= ? AND max >= ?', score, score).last
  #aca le sumo uno al rango, de alguna forma la cant total de alumnos tiene que viajar para al final convertir esto en un %
  #le agrego al final un sc[total][lenguaje][1basico] con el total de alumnos de ese curso
  #y despues en el view hago sc[simce1][lenguaje][1basico][rango] vs sc[total][lenguaje][1basico]
  #@school_student_by_level[school][srip_and_downcase(range.nombre)][assignature.id][level.id] += 1 if range.present?
  @school_student_by_level[school][assignature.id][level.id][srip_and_downcase(range.nombre)] += 1 if range.present?
end

def compare_get_percentage range, assignature, level, school , year
  #obtengo la cantidad de alumnos del rango
  #por cada rango 
  score = nil
  total_students = @school_answers_range[school][year][assignature.id][level.id].group_by(&:student_id).count
  students_amount = @school_student_by_level[school][assignature.id][level.id][srip_and_downcase(range.nombre)] if @school_student_by_level[school][assignature.id][level.id][srip_and_downcase(range.nombre)].present?
  if(total_students > 0)
    score = (students_amount*100/total_students.to_f).try(:round)
  end
  score.present? ? score.to_s + '%' : 'N/D'
end


def compare_get_avg range, assignature, level, year
#recibo rango asignatura y nivel , flateo y promedio esos numeros
avg = 0
procs_amount = 0
score = 0
  @proccesses.each do |school|
    if @school_student_by_level[school][assignature.id][level.id][srip_and_downcase(range.nombre)].present?
      total_students = @school_answers_range[school][year][assignature.id][level.id].group_by(&:student_id).count
      if total_students > 0 
        students_amount = @school_student_by_level[school][assignature.id][level.id][srip_and_downcase(range.nombre)]
        score += (students_amount*100/total_students.to_f).round
      end
      procs_amount += 1
    end
  end

  score_final = (score/procs_amount.to_f).round
  score_final.present? ? score_final.to_s + '%' : 'N/D'
end

def compare_set_student_level_and_range
  #aca lleno los arrays/objetos vacios
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
end

def get_assignature_level_procs assignature_id, level_id
  @pme_abilities_school_level[level_id].map{|pme| pme if pme.assignature_id == assignature_id}.compact
end

    #################### METODOS COMPARE REPORT END ########################################################

    def school_get_all_pme_ability_score grade, assignature, type, year, school
                        @data = {}
                        @data[school] = {}
                        # PmeAbility.all.each do |pme_ability|
                        get_assignature_level_pme_abilities(assignature.id, grade.level.id).each do |pme_ability|
                          @data[school][pme_ability.id] = school_group_students_with_their_level(grade, assignature, pme_ability, type, year, school)
                        end
                      end
  
                      def school_set_student_level_and_range assignature, grade, school
                        @school_student_by_level = {}
                        @school_student_by_level[school] = {}
                        @school_student_by_level[school]['absent'] = {}

                        @colors = ColorRange.assignature_level_based_evaluation(assignature, grade, @evaluation_type)
                        @colors.sort_by(&:min).map{ |range| @school_student_by_level[school][srip_and_downcase(range.nombre)] = 0 }
                      end
                      
                      #TODO , modificar esta funcion para que considere respuestas omitidas y las ponga como incorrectas
                      #estoy recibiendo cantidad de correctas, cantidad de contestadas, total de preguntas y school
                      def school_calculate_percent_and_level correct_ans, student_ans, all_quest, school
                        score = percent(correct_ans, student_ans)
                        if @evaluation_type.short_name == 'simce'
                          score = (score*2.05+156).to_f.round
                        end
                        range = @colors.where('min <= ? AND max >= ?', score, score).last
                        @school_student_by_level[school][srip_and_downcase(range.nombre)] += 1 if range.present?
                      end
  
                      def school_chart_required_data_present? year, assignature, school
                        school_get_assignature_score(year, assignature, school)
                        Hash[*@data[school].flatten].values.reject{|s| s==0}.present?
                      end
  
                      def school_get_assignature_score year, assignature, school
                        @data[school] = @levels.map{ |level| [ level.nombre, @school_result[year][school][assignature.id][level.id].to_i ] if (@school_result[year][school][assignature.id][level.id].to_i != 0 && @school_result[year][school][assignature.id].values.compact.present?) }.compact
                        @values = @levels.map{ |level| @school_result[year][school][assignature.id][level.id].to_i }.flatten.compact
                      end
  
                      def school_get_chart_data school
                        @data[school].push(['Promedio Establecimiento', (@values.sum/@values.reject { |c| c==0 }.count rescue 0)])
                      end
  
                        def not_last_level_and_data_present? year, level
      school_grouped_by_level(year).keys.last != level && @data.present? && @data.values.reject{|d| d.blank?}.present?
    end
    #####################################################################################
  
    def assignature_score_n_average year, level, assignature
      score = @result[year][level.id][assignature.id]
      @avrg[year][assignature.id] << score.to_i if score.present?
      score.nil? ? 'N/D' : score.to_s + '%'
    end
  
    def pme_ability_score_n_average year, assignature, level, pme_ability
      #if @result_pme_abilities[year][level.id][pme_ability.id].present?

        score = @result_pme_abilities[year][assignature.id][level.id][pme_ability.id]

        @avg_pme_level[year][assignature.id][level.id] << score.to_i if score.present? 
        @avg_pme_ability_totals[year][assignature.id][pme_ability.id] << score.to_i if score.present?
        score.nil? ? 'N/D' : score.to_s + '%'      
      #end
    end
  
    def assignature_assignature_ability_score_n_average year, assignature, level, pme_ability
      #if @result_assignature_abilities[year][level.id][pme_ability.id].present?
        score = @result_assignature_abilities[year][assignature.id][level.id][pme_ability.id]
        @avg_assignature_ability_level[year][assignature.id][level.id] << score.to_i if score.present? 
        @avg_assignature_ability_totals[year][assignature.id][pme_ability.id] << score.to_i if score.present?
        score.nil? ? 'N/D' : score.to_s + '%'      
      #end
    end
  
    def assignature_bloom_ability_score_n_average year, assignature, level, pme_ability
      #if @result_bloom_abilities[year][assignature.id][level.id][pme_ability.id].present?
        score = @result_bloom_abilities[year][assignature.id][level.id][pme_ability.id]
        @avg_bloom_ability_totals[year][assignature.id][pme_ability.id] << score.to_i if score.present?
        @avg_bloom_ability_level[year][assignature.id][level.id] << score.to_i if score.present?
        score.nil? ? 'N/D' : score.to_s + '%'      
     #end
    end
  
    def pme_ability_avg year, assignature, level
      #columna "promedio curso % logro"
      if @avg_pme_level[year][assignature.id][level.id].try(:flatten).try(:compact).present?
        (@avg_pme_level[year][assignature.id][level.id].try(:flatten).try(:compact).try(:sum).to_f/@avg_pme_level[year][assignature.id][level.id].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def assignature_ability_avg year, assignature, level
      if @avg_assignature_ability_level[year][assignature.id][level.id].try(:flatten).try(:compact).present?
        (@avg_assignature_ability_level[year][assignature.id][level.id].try(:flatten).try(:compact).try(:sum).to_f/@avg_assignature_ability_level[year][assignature.id][level.id].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
    
    def bloom_ability_avg year, assignature, level
      #puts "PROMEDIOS FILA LEVEL PARA COLUMNA TOTALES"
      #puts @avg_bloom_ability_level[year][assignature.id][level.id].inspect
      if @avg_bloom_ability_level[year][assignature.id][level.id].try(:flatten).try(:compact).present?
        (@avg_bloom_ability_level[year][assignature.id][level.id].try(:flatten).try(:compact).try(:sum).to_f/@avg_bloom_ability_level[year][assignature.id][level.id].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def color_range assignature, grade, evaluation_type
      @colors = ColorRange.assignature_level_based_evaluation(assignature, grade, @evaluation_type)
    end
  
    def grade_level_name grade
      grade.level.nombre + ' ' + grade.letra
    end
  
    def get_assignature_score year, assignature
      @data = @levels.map{ |level| [ level.nombre, @result[year][level.id][assignature.id].to_i ] if (@result[year][level.id][assignature.id].to_i != 0 && @result[year][level.id].values.compact.present?) }.compact
      @values = @levels.map{ |level| @result[year][level.id][assignature.id].to_i }.flatten.compact
    end
  
    def get_chart_data
      @data.push(['Promedio Establecimiento', (@values.sum/@values.reject { |c| c==0 }.count rescue 0)])
    end
  
    def get_all_pme_ability_score grade, assignature, type, year
      @data = {}
      # PmeAbility.all.each do |pme_ability|
      get_assignature_pme_abilities(assignature.id).each do |pme_ability|
        @data[pme_ability.id] = group_students_with_their_level(grade, assignature, pme_ability, type, year)
      end
    end
  
    def not_last_level_and_data_present? year, level
      school_grouped_by_level(year).keys.last != level && @data.present? && @data.values.reject{|d| d.blank?}.present?
    end
  
    def chart_required_data_present? year, assignature
      get_assignature_score(year, assignature)
      Hash[*@data.flatten].values.reject{|s| s==0}.present?
    end
  
    def school_score_n_average(year, assignature_id, assign_ability)
      score = @achievement_of_school[year][assignature_id][assign_ability.id]
      @avrg[year][assignature_id][assign_ability.id] << score if score.present?
      @avrg[year]['promedio'] << score if score.present? rescue nil
      score.present? ? score.to_s + '%' : 'N/D'
    end
  
    def average_all_year assignature_id, assignature_ability
      scores =  @comparative_years.map{ |year|
                  @avrg[year][assignature_id][assignature_ability.id].try(:flatten).try(:compact)
                }.flatten.compact
      if scores.present?
        ((scores.try(:sum)/scores.try(:count)) rescue 0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def get_assignature_abilities data
      @assignature_abilities = data.collect(&:assignature_ability).uniq.flatten.compact
    end
  
    def assignature_ability_score_n_average year, level, assignature_id, assignature_ability_id
      score = @result[year][level.id][assignature_id][assignature_ability_id]
      @avrg[year][assignature_id][assignature_ability_id] << score if score.present?
      score.nil? ? 'N/D' : score.to_s + '%'
    end
  
    def average_per_pme_ability assignature_id, pme_ability_id, year
      #puts "FILA TOTALES"
      if @avg_pme_ability_totals[year][assignature_id][pme_ability_id].try(:compact).present?
        score = (@avg_pme_ability_totals[year][assignature_id][pme_ability_id].try(:compact).try(:sum)/@avg_pme_ability_totals[year][assignature_id][pme_ability_id].try(:compact).try(:count))
        @avg_pme_ability_totals[year][assignature_id]['avg'] << score if score.present?      
        score.to_s + '%'
      else
        'N/D'
      end
    end
  
    def average_per_assignature_ability assignature_id, pme_ability_id, year
      #puts "FILA TOTALES"
      if @avg_assignature_ability_totals[year][assignature_id][pme_ability_id].try(:compact).present?
        score = (@avg_assignature_ability_totals[year][assignature_id][pme_ability_id].try(:compact).try(:sum)/@avg_assignature_ability_totals[year][assignature_id][pme_ability_id].try(:compact).try(:count))
        @avg_assignature_ability_totals[year][assignature_id]['avg'] << score if score.present?      
        score.to_s + '%'
      else
        'N/D'
      end
    end
  
    def average_per_bloom_ability assignature_id, assignature_ability_id, year
      #puts "FILA TOTALES"
      #puts @avg_bloom_ability_totals
      if @avg_bloom_ability_totals[year][assignature_id][assignature_ability_id].try(:compact).present?
        score = (@avg_bloom_ability_totals[year][assignature_id][assignature_ability_id].try(:compact).try(:sum)/@avg_bloom_ability_totals[year][assignature_id][assignature_ability_id].try(:compact).try(:count))
        @avg_bloom_ability_totals[year][assignature_id]['avg'] << score if score.present?      
        score.to_s + '%'
      else
        'N/D'
      end
    end
  
    def last_avg_bloom_abilities assignature_id, year
      #puts "ULTIMA CELDA"
      if @avg_bloom_ability_totals[year][assignature_id]['avg'].try(:compact).present?
        (@avg_bloom_ability_totals[year][assignature_id]['avg'].try(:compact).try(:sum).to_f/@avg_bloom_ability_totals[year][assignature_id]['avg'].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def last_avg_pme_abilities assignature_id, year
      #puts "ULTIMA CELDA"
      if @avg_pme_ability_totals[year][assignature_id]['avg'].try(:compact).present?
        (@avg_pme_ability_totals[year][assignature_id]['avg'].try(:compact).try(:sum).to_f/@avg_pme_ability_totals[year][assignature_id]['avg'].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def last_avg_assignature_abilities assignature_id, year
      #puts "ULTIMA CELDA"
      if @avg_assignature_ability_totals[year][assignature_id]['avg'].try(:compact).present?
        (@avg_assignature_ability_totals[year][assignature_id]['avg'].try(:compact).try(:sum).to_f/@avg_assignature_ability_totals[year][assignature_id]['avg'].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def average_per assignature, year
      if @avrg[year][assignature.id].try(:compact).present?
        (@avrg[year][assignature.id].try(:compact).try(:sum).to_f/@avrg[year][assignature.id].try(:compact).try(:count)).round(0).to_s + '%'
      else
        'N/D'
      end
    end
  
    def average_per_ability assignature_id, assignature_ability_id, year
      if @avrg[year][assignature_id][assignature_ability_id].try(:compact).present?
        (@avrg[year][assignature_id][assignature_ability_id].try(:compact).try(:sum)/@avrg[year][assignature_id][assignature_ability_id].try(:compact).try(:count)).to_s + '%'
      else
        'N/D'
      end
    end
  
    def school_grouped_by_level year
      #get present levels
      level_ids = @levels.collect(&:id)
      #@for_school.last.grades.where(year: year).sort_by(&:level_id).group_by(&:level_id)
      @for_school.last.grades.where(year: year, level_id: level_ids).sort_by(&:level_id).group_by(&:level_id)
    end
  
    def get_graph_data year, assignature_id, ability
      @levels.collect{ |level| @result[year][level.id][assignature_id][ability.id].to_i }
    end
  
    def assigned_school_order_years_option
      @daem_user.assigned_schools.collect(&:school).flatten.compact.collect(&:orders).flatten.compact.sort_by{|order| order[:year] }.collect(&:year).compact.uniq rescue []
    end
  
    def calculate_levels_assignatures_students year, report
      #BORRAR ESTO DESPUES
      #@levels = Level.where(id: 2)
      @levels.each do |level|
        @result[year][level.id] = {}
        @answers[year][level.id] = {}
        send('data_calculation_for_'+report, year, level)
      end
    end
  
    def calculate_levels_assignatures_students_daem year, report
      #BORRAR ESTO DESPUES
      #@levels = Level.where(id: 2)
     # @for_school.each do |school|
      # @school_result[year][school] = {}
      #  @school_answers[school][year] = {}
     # end
      
      #@for_school.each do |school|
       # @levels.each do |level|
          #@school_result[school][year][level.id] = {}
          #@school_answers[school][year][level.id] = {}
          #send('data_calculation_for_'+report, year, level)
          if report == 'report_8'
            send('data_calculation_for_report_8', year)
          else
            send('data_calculation_for_report_7', year)
          end

  
      # end
    #end
    end
  
    def calculate_school_achievement year
      @assignatures.map do |assignature_id, data|
        @achievement_of_school[year][assignature_id] = {}
        data.collect(&:assignature_ability_id).uniq.map{|ability_id| @avrg[year][ability_id] = [] }
  
        @assign_abilities = data.sort_by(&:assignature_ability_id).group_by(&:assignature_ability_id)
  
        @assign_abilities.map do |ability_id, questions|
  
          all_answers = @ans[year].where('evaluations.assignature_id': assignature_id, 'questions.assignature_ability_id': ability_id)
          correct_answers = all_answers.where(correct: true)
          @achievement_of_school[year][assignature_id][ability_id] = percent(correct_answers, all_answers)
  
          @avrg[year][ability_id] << @achievement_of_school[year][assignature_id][ability_id]
        end
      end
    end
  
    def data_calculation_for_report_1 year, level
      @assignatures.map do |assignature_id, data|
        @answers[year][level.id][assignature_id] = {}
  
        assignature_abilities = data.collect(&:assignature_ability_id).uniq
  
        @avrg[year][assignature_id] = {}
        @result[year][level.id][assignature_id] = {}
  
        assignature_abilities.map{ |ability_id|
          @avrg[year][assignature_id][ability_id] = []
        }
  
        assignature_abilities.each do |assignature_ability_id|
          level_assig_ans = @ans[year].where('grades.level_id': level.id, 'questions.assignature_id': assignature_id, 'questions.assignature_ability_id': assignature_ability_id)
          correct_ans = level_assig_ans.where(correct: true)
  
          @result[year][level.id][assignature_id][assignature_ability_id] = percent(correct_ans, level_assig_ans)
  
          @answers[year][level.id][assignature_id][assignature_ability_id] = level_assig_ans.where('questions.assignature_ability_id': assignature_ability_id)
        end
      end
    end
  
    def data_calculation_for_report_5 year, level
      @colors_set = Result.color_set.inspect.html_safe
      @assignatures.map do |assignature| 
        
        @answers[year][level.id][assignature.id] = {}
        #hashes
        @result_pme_abilities[year][assignature.id][level.id] = {} 
        @result_assignature_abilities[year][assignature.id][level.id] = {} 
        @result_bloom_abilities[year][assignature.id][level.id] = {} 
        #@result_bloom_abilities[year][assignature.id] = {}      
        @avg_pme_level[year][assignature.id][level.id] = []
        @avg_assignature_ability_level[year][assignature.id][level.id] = []
        @avg_bloom_ability_level[year][assignature.id][level.id] = []      
  
        #testing 
        @avrg[year][assignature.id] = []
        level_assig_ans = @ans[year].where('grades.level_id': level.id, 'evaluations.assignature_id': assignature.id)
        cantidad_presentes = level_assig_ans.collect(&:student_id).uniq.count   
        correct_ans = level_assig_ans.where(correct: true)
        pi = level_assig_ans.collect(&:proccess_instrument_id).uniq

        cantidad_preguntas = 0
        if pi.present? 
          cantidad_preguntas = ProccessInstrument.find(pi).last.instrument.evaluation.questions.count
        end

        total_preguntas_level_assig = cantidad_preguntas * cantidad_presentes
        tp_assig = []
        total_preguntas_level_assig.times { tp_assig.push(1) }
  
        @result[year][level.id][assignature.id] = percent(correct_ans, tp_assig)
  
        PmeAbility.all.each do |ability|
          @answers[year][level.id][assignature.id][ability.id] = level_assig_ans.where('questions.pme_ability_id': ability.id)
          #adding pme_ability hash
          pme_level_assig_ans = @ans[year].where('grades.level_id': level.id, 'questions.pme_ability_id': ability.id)
          pme_correct_ans = pme_level_assig_ans.where(correct: true)
          #cuando un alumno omite una pregunta no se esta considerando en el promedio
          #por lo tanto el verdadero total no es answers con una habilidad
          #el verdadero total es preguntas de esa habilidad multiplicado por los presentes
          #primero nos aseguramos de extraer la evaluacion, porque si calculamos en base a respuestas y una pregunta fue omitida por todos no va a contar en el total
          cantidad_preguntas_pme = 0
          if pi.present? 
            cantidad_preguntas_pme = ProccessInstrument.find(pi).last.instrument.evaluation.questions.where(pme_ability_id: ability.id).count
          end

          total_preguntas = cantidad_preguntas_pme * cantidad_presentes
          tp = []
          total_preguntas.times { tp.push(1) }
          
          @result_pme_abilities[year][assignature.id][level.id][ability.id] = percent(pme_correct_ans, tp) 
          @avg_pme_ability_totals[year][assignature.id][ability.id] = []
        end
  
        AssignatureAbility.all.each do |ability|
          #@answers[year][level.id][assignature.id][ability.id] = level_assig_ans.where('questions.assignature_ability_id': ability.id)        
          #adding pme_ability hash
          assignature_ability_level_assig_ans = @ans[year].where('grades.level_id': level.id, 'questions.assignature_ability_id': ability.id)
          assignature_ability_correct_ans = assignature_ability_level_assig_ans.where(correct: true)

          #update para fixear omitidas
          cantidad_presentes = level_assig_ans.collect(&:student_id).uniq.count
          pi = level_assig_ans.collect(&:proccess_instrument_id).uniq
          cantidad_preguntas_pme = 0
          if pi.present? 
            cantidad_preguntas_pme = ProccessInstrument.find(pi).last.instrument.evaluation.questions.where(assignature_ability_id: ability.id).count
          end

          total_preguntas = cantidad_preguntas_pme * cantidad_presentes
          tp = []
          total_preguntas.times { tp.push(1) }

          @result_assignature_abilities[year][assignature.id][level.id][ability.id] = percent(assignature_ability_correct_ans, tp) 
          @avg_assignature_ability_totals[year][assignature.id][ability.id] = []
        end
  
        BloomAbility.all.each do |bloom|
          #adding pme_ability hash
          bloom_level_assig_ans = @ans[year].where('grades.level_id': level.id, 'questions.bloom_ability_id': bloom.id,  'evaluations.assignature_id': assignature.id)
          bloom_correct_ans = bloom_level_assig_ans.where(correct: true)
          #update para fixear omitidas
          cantidad_presentes = level_assig_ans.collect(&:student_id).uniq.count
          pi = level_assig_ans.collect(&:proccess_instrument_id).uniq
          cantidad_preguntas_pme = 0
          if pi.present? 
            cantidad_preguntas_pme = ProccessInstrument.find(pi).last.instrument.evaluation.questions.where(bloom_ability_id: bloom.id).count
          end
          total_preguntas = cantidad_preguntas_pme * cantidad_presentes
          tp = []
          total_preguntas.times { tp.push(1) }

          @result_bloom_abilities[year][assignature.id][level.id][bloom.id] = percent(bloom_correct_ans, tp)
          @avg_bloom_ability_totals[year][assignature.id][bloom.id] = []
        end      
        @avg_bloom_ability_totals[year][assignature.id]['avg'] = []
        @avg_pme_ability_totals[year][assignature.id]['avg'] = []
        @avg_assignature_ability_totals[year][assignature.id]['avg'] = []
      end  
    end
  
    def data_calculation_for_report_7 year
      @school_avrg[year]['comunal'] = {}
      @colors_set = Result.color_set.inspect.html_safe
      @school_result[year] = {}      
      @assignatures.each do |as|
        @school_avrg_totals[year][as.id] = []
        @school_avrg[year]['comunal'][as.id] = {}
        @levels.each do |level|
          @school_avrg[year]['comunal'][as.id][level.id] = []
        end
      end
      
      @for_school.map do |school|
        @school_avrg[year][school] = {}   
        @school_answers[school][year] = {}
        @school_result[year][school] = {}
  
        @assignatures.each do |assignature|
          @school_answers[school][year][assignature.id] = {}        
          @school_result[year][school][assignature.id] = {}        
          @school_avrg[year][school][assignature.id] = []
          @levels.each do |level|
            @school_result[year][school][assignature.id][level.id] = {}
            @school_avg_pme_level[school][year][assignature.id][level.id] = []
            #@school_answers[school][year][level.id] = {}
            #@school_answers[school][year][level.id][assignature.id] = {}
  
            @school_answers[school][year][assignature.id][level.id] = {}
            @school_avg_pme_ability_totals[year][assignature.id][level.id] = {}
            #hashes
            @school_result_pme_abilities[school][year][assignature.id][level.id] = {} 
            
            school_assig_ans = @school_ans[school][year].where('grades.level_id': level.id,'evaluations.assignature_id': assignature.id)
            correct_ans = school_assig_ans.where(correct: true)
            cantidad_presentes = school_assig_ans.collect(&:student_id).uniq.count
            #school_assign_ans != total preguntas
            pi = school_assig_ans.collect(&:proccess_instrument_id).uniq

            cantidad_preguntas = 0
            if pi.present? 
              cantidad_preguntas = ProccessInstrument.find(pi).last.instrument.evaluation.questions.count
            end
    
            total_preguntas_level_assig = cantidad_preguntas * cantidad_presentes
            tp_assig = []
            total_preguntas_level_assig.times { tp_assig.push(1) }

            score_assignature = percent(correct_ans, tp_assig)
            @school_result[year][school][assignature.id][level.id] = score_assignature
            @school_avrg[year][school][assignature.id] << score_assignature.to_i if score_assignature.present?
  
            PmeAbility.all.each do |ability|
              #@school_answers[school][year][level.id][assignature.id][ability.id] = school_assig_ans.where('questions.pme_ability_id': ability.id)
              @school_answers[school][year][assignature.id][level.id][ability.id] = school_assig_ans.where('questions.pme_ability_id': ability.id)
              #adding pme_ability hash
              pme_level_assig_ans = @school_ans[school][year].where('grades.level_id': level.id, 'questions.pme_ability_id': ability.id, 'evaluations.assignature_id': assignature.id)
              pme_correct_ans = pme_level_assig_ans.where(correct: true)
              #cuando un alumno omite una pregunta no se esta considerando en el promedio
              #por lo tanto el verdadero total no es answers con una habilidad
              #el verdadero total es preguntas de esa habilidad multiplicado por los presentes
              cantidad_presentes = school_assig_ans.collect(&:student_id).uniq.count
              #primero nos aseguramos de extraer la evaluacion, porque si calculamos en base a respuestas y una pregunta fue omitida por todos no va a contar en el total
              pi = school_assig_ans.collect(&:proccess_instrument_id).uniq
              cantidad_preguntas_pme = 0
              if pi.present? 
                cantidad_preguntas_pme = ProccessInstrument.find(pi).last.instrument.evaluation.questions.where(pme_ability_id: ability.id).count
              end
              total_preguntas = cantidad_preguntas_pme * cantidad_presentes
              tp = []
              total_preguntas.times { tp.push(1) }

              @school_result_pme_abilities[school][year][assignature.id][level.id][ability.id] = percent(pme_correct_ans, tp) 
              @school_avg_pme_ability_totals[year][assignature.id][level.id][ability.id] = []
            end
          #total pme abilities por level
          @school_avg_pme_ability_totals[year][assignature.id][level.id]['avg'] = []
          end
          #termina calculo de cursos
          avg_ass = @school_avrg[year][school][assignature.id].try(:flatten).try(:compact)
          if avg_ass.present?
            score = (avg_ass.inject{|sum, el| sum + el }.to_f / avg_ass.size).round
            @school_avrg_totals[year][assignature.id] << score if score.present?         
          end
        end
        #termina calculo colegio
      end
      #terminan todos los calculos
    end

    def data_calculation_for_report_8 year
      #compare_set_student_level_and_range
      @school_avrg[year]['comunal'] = {}

      @colors_set = Result.color_set.inspect.html_safe
      @school_result[year] = {}      
      @assignatures.each do |as|
        @school_avrg_totals[year][as.id] = []
        @school_avrg[year]['comunal'][as.id] = {}
        @levels.each do |level|
          @school_avrg[year]['comunal'][as.id][level.id] = []
          @proccesses.map do |school| 
            
          end
        end
      end
      
      @proccesses.map do |school|
        @school_avrg[year][school] = {}   
        @school_answers[school][year] = {}
        @school_answers_range[school][year] = {}
        @school_result[year][school] = {}
        @school_avg_pme_proc[school] = {}
        @school_avg_pme_proc[school][year] = {}

        @assignatures.each do |assignature|
          @school_avg_pme_proc[school][year][assignature.id] = {}
          @school_answers[school][year][assignature.id] = {}        
          @school_answers_range[school][year][assignature.id] = {}        
          @school_result[year][school][assignature.id] = {}        
          @school_avrg[year][school][assignature.id] = []
          @levels.each do |level|
            @school_result[year][school][assignature.id][level.id] = {}
            @school_avg_pme_level[school][year][assignature.id][level.id] = []
            #@school_answers[school][year][level.id] = {}
            #@school_answers[school][year][level.id][assignature.id] = {}
  
            @school_answers[school][year][assignature.id][level.id] = {}
            @school_avg_pme_ability_totals[year][assignature.id][level.id] = {}
            #hashes
            @school_result_pme_abilities[school][year][assignature.id][level.id] = {} 

            school_assig_ans = @school_ans[school][year].where('grades.level_id': level.id,'evaluations.assignature_id': assignature.id)
            @school_answers_range[school][year][assignature.id][level.id] = school_assig_ans
            correct_ans = school_assig_ans.where(correct: true)
            score_assignature = percent(correct_ans, school_assig_ans)
            @school_result[year][school][assignature.id][level.id] = score_assignature
            @school_avrg[year][school][assignature.id] << score_assignature.to_i if score_assignature.present?
  
            PmeAbility.all.each do |ability|
              #@school_answers[school][year][level.id][assignature.id][ability.id] = school_assig_ans.where('questions.pme_ability_id': ability.id)
              @school_answers[school][year][assignature.id][level.id][ability.id] = school_assig_ans.where('questions.pme_ability_id': ability.id)
              #adding pme_ability hash
              pme_level_assig_ans = @school_ans[school][year].where('grades.level_id': level.id, 'questions.pme_ability_id': ability.id, 'evaluations.assignature_id': assignature.id)
              pme_correct_ans = pme_level_assig_ans.where(correct: true)
              #cuando un alumno omite una pregunta no se esta considerando en el promedio
              #por lo tanto el verdadero total no es answers con una habilidad
              #el verdadero total es preguntas de esa habilidad multiplicado por los presentes
              cantidad_presentes = school_assig_ans.collect(&:student_id).uniq.count
              #primero nos aseguramos de extraer la evaluacion, porque si calculamos en base a respuestas y una pregunta fue omitida por todos no va a contar en el total
              pi = school_assig_ans.collect(&:proccess_instrument_id).uniq
              cantidad_preguntas_pme = 0
              if pi.present? 
                cantidad_preguntas_pme = ProccessInstrument.find(pi).last.instrument.evaluation.questions.where(pme_ability_id: ability.id).count
              end
              total_preguntas = cantidad_preguntas_pme * cantidad_presentes
              tp = []
              total_preguntas.times { tp.push(1) }

              @school_result_pme_abilities[school][year][assignature.id][level.id][ability.id] = percent(pme_correct_ans, tp)
              @school_avg_pme_ability_totals[year][assignature.id][level.id][ability.id] = []
              @school_avg_pme_proc[school][year][assignature.id][ability.id] = []

            end
          #total pme abilities por level
          @school_avg_pme_ability_totals[year][assignature.id][level.id]['avg'] = []
          compare_group_students_with_their_level(level, assignature, year, school)
          end
          #termina calculo de cursos
          avg_ass = @school_avrg[year][school][assignature.id].try(:flatten).try(:compact)
          if avg_ass.present?
            score = (avg_ass.inject{|sum, el| sum + el }.to_f / avg_ass.size).round
            @school_avrg_totals[year][assignature.id] << score if score.present?         
          end
        end
        #termina calculo colegio
      end
      #terminan todos los calculos
    end
  
    def data_grouped_by_school_for_report_4
      @school_ans = {}
      @assignature_avrg = {}
      @comparative_years.each do |year|
        @assignature_avrg[year] = {}
        @assignatures.map do |assignature_id,data|
          @assignature_avrg[year][assignature_id] = {}
  
          @assignature_abilities = data.collect(&:assignature_ability_id).uniq
          @assignature_abilities.map { |ass_ability_id| @assignature_avrg[year][assignature_id][ass_ability_id]  = [] }
        end
      end
  
      @for_school.collect(&:id).each do |school_id|
        @school_ans[school_id] = {}
        @comparative_years.each do |year|
          @school_ans[school_id][year] = {}
  
          @school_ans[school_id][year][:all] = Answer.joins(:question).joins(proccess_instrument: { proccess: { order: :school }, instrument: { evaluation: :evaluation_type } }).joins(proccess_instrument: :grade).where('schools.id': school_id, 'grades.year': year, 'orders.year': year, 'evaluation_types.id': @evaluation_type.id).uniq
  
          @assignatures.map do |assignature_id, data|
            @school_ans[school_id][year][assignature_id] = {}
  
            @assignature_abilities.each do |assignature_ability_id|
              all_answers = @school_ans[school_id][year][:all].where('questions.assignature_id': assignature_id, 'questions.assignature_ability_id': assignature_ability_id)
  
              correct_answers = all_answers.where(correct: true)
              @school_ans[school_id][year][assignature_id][assignature_ability_id] = percent(correct_answers, all_answers)
  
              @school_ans[school_id][year][:avrg] = [] if @school_ans[school_id][year][:avrg].nil?
              @school_ans[school_id][year][:avrg] << @school_ans[school_id][year][assignature_id][assignature_ability_id]
              @assignature_avrg[year][assignature_id][assignature_ability_id] << @school_ans[school_id][year][assignature_id][assignature_ability_id]
            end
          end
        end
      end
    end
  
    def daem_users_list
      (User.with_role :daem).collect{ |user| [user.full_name, user.id] }.unshift(['Seleccione usuario DAEM', nil])
    end
  
    def default_assigned_school_order_year_option type
      years = @daem_user.assigned_schools.collect(&:school).flatten.compact.collect(&:orders).flatten.compact.sort_by{|order| order[:year] }.collect(&:year).compact rescue []
      case type
        when :start
          years.reverse[1]
        when :end
          years.reverse[0]
        end
    end
  
    def default_order_year_option type
      years = @comparative_school.orders.order(:year).collect(&:year).compact
      case type
        when :start
          years.reverse[1]
        when :end
          years.reverse[0]
        end
    end
    
    def get_report_heading report
      title = case report
                when 1
                  ("Análisis resultados evaluaciones #{@for_school.last.nombre} <br>Para Establecimiento<br>Evaluaciones con indicadores PME<br>Comparativo")
                when 2
                  ("Análisis resultados evaluaciones #{@for_school.last.nombre} <br>Para Sostenedor Evaluaciones con <br>indicadores PME<br>Comparativo")
                when 3
                  ("Análisis resultados evaluaciones #{@for_school.last.nombre} <br>Para Sostenedor Evaluaciones <br>SIMCE<br>Comparativo")
                when 4
                  ("Análisis resultados evaluaciones #{@for_school.last.nombre} <br>Para Sostenedor Evaluaciones con <br>indicadores PME<br>Comparativo")
                when 5
                  ("Análisis resultados evaluaciones #{@params['ending_year']} Cobertura Curricular - Evaluación #{@params['proccess']} Consolidado - #{@for_school.last.nombre}")
                when 7
                  ("Análisis resultados evaluaciones #{@params['ending_year']} Cobertura Curricular - Evaluación #{@params['proccess']} Consolidado Sostenedor")
                when 8
                  ("Análisis resultados evaluaciones #{@params['ending_year']} Cobertura Curricular - Comparativo NIVEL #{@for_school.last.nombre}")
                when 9
                  ("Análisis resultados evaluaciones #{@params['ending_year']} Cobertura Curricular - Comparativo SIMCE #{@for_school.last.nombre}")
                end
      title.html_safe
    end
  
    def group_students_with_their_level grade, assignature, pme_ability, type, year
      school_id =  @params['school'].to_i
      proctype = ProcType.where(nombre: @params['proccess']).last.id
      pme_questions = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': school_id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).reject{ |e| e.level_id != grade.level.id }.uniq.flatten.compact.collect(&:questions).flatten.compact.reject{ |q| q.pme_ability_id != pme_ability.id}.uniq  
      set_student_level_and_range(assignature, grade)
      @all_answers =  if type == 'joined'
                        @answers[year][grade.level_id][assignature.id][pme_ability.id] 
                      else
                        @answers[year][grade.level_id][assignature.id][pme_ability.id].where('grades.id': grade.id) 
                      end
      group_by_students = @all_answers.group_by(&:student_id)
      total_students =  if type == 'joined'
        grade.school.grades.where(year: grade.year, level_id: grade.level_id).collect(&:students).flatten.compact.count
      else
        grade.students.count
      end

present_students =  if type == 'joined'
      @ans[year].where('evaluations.level_id': grade.level.id, 'evaluations.assignature_id': assignature.id ).collect(&:student_id).uniq.count                      
    else
      @ans[year].where('grades.id': grade.id, 'evaluations.assignature_id': assignature.id ).collect(&:student_id).uniq.count                      
    end

      group_by_students.map do |student,s_answers|
        correct_answers = s_answers.select{ |ans| ans.correct }      
        calculate_percent_and_level(correct_answers, pme_questions, s_answers.collect(&:question).uniq.count)
      end
  
    ##### calculo porcentajes de alumnos omitidos que equivale a : alumos con algo - alumnos con algo en este pme hab
    missing_students = present_students - group_by_students.count

    missing_students.times { calculate_percent_and_level([], pme_questions, 0) }
      #@student_by_level['absent'] = total_students - group_by_students.keys.count
      @student_by_level['absent'] = total_students - present_students
      group_by_students
   end
  
    def order_years_option
      @comparative_school.orders.order(:year).collect(&:year).compact.uniq
    end
  
    def report_options
      if current_user.has_role?(:daem) || current_user.user_type.role.eql?('admin')
        [['Seleccione informe', nil],['Consolidado NIVEL', 5], ['Consolidado SIMCE', 6], ['Consolidado NIVEL Sostenedor', 7],['Consolidado SIMCE Sostenedor', 8],['Comparativo NIVEL', 9],['Comparativo SIMCE', 10]]
        # %w(1 2 3 4 5).map{ |i| ['Informe '+i, i] }.unshift(['Seleccione informe', nil])
      else
        [['Seleccione informe', nil],['Comparativo NIVEL', 1],['Comparativo SIMCE', 3],['Consolidado NIVEL', 5],['Consolidado SIMCE', 6]]
        # %w(1 3 5).map{ |i| ['Informe '+i, i] }.unshift(['Selecciones informe'])
      end
    end
  
    def school_options
      if current_user.user_type.role.eql?('admin')
        School.all.order(:nombre).collect{ |s| [s.nombre, s.id] }.unshift(['Seleccione Establecimiento', nil])
      elsif current_user.has_role?(:daem)
        current_user.assigned_schools.collect(&:school).collect{ |s| [s.nombre, s.id] }.unshift(['Seleccione Establecimiento', nil])
      end
    end
  
    def school_levels_and_assignatures year, report
      @levels = @for_school.map{ |school| school.grades.where(year: year).collect(&:level) }.flatten.compact.uniq.sort_by(&:id)
      proctype = ProcType.where(nombre: @params['proccess']).try(:last).try(:id)
      
      if report == 'report_8'
        if @evaluation_type.short_name == 'simce'
          ptf = 2
        else
          ptf = 1
        end
      end

      @assignatures =
        case report
          when 'report_1'
            @ans.values.flatten.collect(&:question).uniq.sort_by(&:assignature_id).group_by(&:assignature_id)
          when 'report_5'
            #@for_school.last.grades.where(year: year).collect(&:proccess_instruments).uniq.flatten.compact.collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:assignature).uniq.flatten.compact.sort_by(&:nombre)
            ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:assignature).uniq.flatten.compact.sort_by(&:priority)
          when 'report_7'
            #@for_school.last.grades.where(year: year).collect(&:proccess_instruments).uniq.flatten.compact.collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:assignature).uniq.flatten.compact.sort_by(&:nombre)
             ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.map{|s| s.id} ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:assignature).uniq.flatten.compact.sort_by(&:priority)
          when 'report_8'
            ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, {proc_type: :proc_type_father}]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_type_fathers.id': ptf).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:assignature).uniq.flatten.compact.sort_by(&:priority)
          end
  
          if report == 'report_7'
            @levels = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.map{|s| s.id} ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:level).uniq.flatten.compact.sort_by(&:id)
          end
          
          if report == 'report_5'
            @levels = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:level).uniq.flatten.compact.sort_by(&:id)
          end

          if report == 'report_8' 
            @levels = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, {proc_type: :proc_type_father}]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_type_fathers.id': ptf).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).collect(&:level).uniq.flatten.compact.sort_by(&:id)
          end
    end
  
    def school_pme_abilities year, report
      #@pme_abilities_school = @for_school.last.grades.where(year: year).collect(&:proccess_instruments).uniq.flatten.compact.collect(&:instrument)
      proctype = ProcType.where(nombre: @params['proccess']).try(:last).try(:id)

      if report == 'report_8'
        if @evaluation_type.short_name == 'simce'
          ptf = 2
        else
          ptf = 1
        end
      end
      
      if report == 'report_8' || report == 'report_9'
        proctype = nil
      end

      if proctype.present? 
        @pme_abilities_school = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:pme_ability).uniq
      else
        #@pme_abilities_school = @pme_abilities_school_level[level.id] = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, {proc_type: :proc_type_father}]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_type_fathers.id': ptf).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:pme_ability).uniq
        @pme_abilities_school = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, {proc_type: :proc_type_father}]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_type_fathers.id': ptf).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:pme_ability).uniq
      end
      
    end

    def school_level_pme_abilities year, report
      school_id = report == 'report_7'? @for_school.collect(&:id) : @for_school.last.id
      #Habilidades pme presentes en un curso
      proctype = ProcType.where(nombre: @params['proccess']).try(:last).try(:id)
      
      if report == 'report_8'
        if @evaluation_type.short_name == 'simce'
          ptf = 2
        else
          ptf = 1
        end
      end

      @levels.each do |level|
        if proctype.present?
        @pme_abilities_school_level[level.id] = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': school_id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).reject { |ev| ev.level_id != level.id }.uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:pme_ability).uniq
        else
        @pme_abilities_school_level[level.id] = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, {proc_type: :proc_type_father}]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_type_fathers.id': ptf).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).reject { |ev| ev.level_id != level.id }.uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:pme_ability).uniq
        end
      end
    end
  
    def school_assignature_abilities year, report
      #@assignature_abilities_school = @for_school.last.grades.where(year: year).collect(&:proccess_instruments).uniq.flatten.compact.collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:assignature_ability).uniq
      proctype = ProcType.where(nombre: @params['proccess']).last.id    
      @assignature_abilities_school = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:assignature_ability).uniq
    end
  
    def school_bloom_abilities year, report
      #@bloom_abilities_school = @for_school.last.grades.where(year: year).collect(&:proccess_instruments).uniq.flatten.compact.collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:bloom_ability).uniq
      proctype = ProcType.where(nombre: @params['proccess']).last.id    
      @bloom_abilities_school = ProccessInstrument.where(report_generated: true).joins(proccess: [{order: :school}, :proc_type]).where('orders.year': year).where('schools.id': @for_school.last.id ).where('proc_types.id': proctype).collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).uniq.flatten.compact.collect(&:bloom_ability).uniq
    end
  
    def get_assignature_pme_abilities assignature_id
      @pme_abilities_school.map{|pme| pme if pme.assignature_id == assignature_id}.compact
    end

    def get_assignature_pme_abilities_proc year, assignature_id 
      school_pme_abilities(year, 'report_8').map{|pme| pme if pme.assignature_id == assignature_id}.compact
    end

    def get_assignature_level_pme_abilities assignature_id, level_id
      @pme_abilities_school_level[level_id].map{|pme| pme if pme.assignature_id == assignature_id}.compact
    end

    def get_assignature_assignature_abilities assignature_id
      @assignature_abilities_school.map{|pme| pme if pme.assignature_id == assignature_id}.compact    
    end
  
    def get_assignature_bloom_abilities year, assignature_id
      #BloomAbility.all
      blooms = []
      bloomAbilities = []
      @levels.each do |level| 
        if @result_bloom_abilities[year][assignature_id][level.id].present?
          blooms << @result_bloom_abilities[year][assignature_id][level.id].map{|k,v| k if v.present?}.compact
        end
      end
  
      if blooms.flatten.count > 0
        bloomAbilities = BloomAbility.find(blooms.flatten.uniq)
      end
      #@ans[year].where('questions.assignature_id': assignature_id).collect(&:proccess_instrument).uniq.flatten.compact.collect(&:instrument).uniq.flatten.compact.collect(&:evaluation).uniq.flatten.compact.collect(&:questions).flatten.compact.collect(&:bloom_ability).uniq    
      bloomAbilities

    end
  
    def level_names_for_chart year, assignature_id
      @levels.map{ |level| level if @result[year][level.id][assignature_id].values.compact.present? }.compact.flatten.collect(&:nombre).compact
    end
  
    def levels_has_values? year, assignature_id
      @levels.map{ |level| @result[year][level.id][assignature_id].values }.flatten.compact.present?
    end
  
    def comparative_graph_data assignature_id, assign_ability
      @comparative_years.collect{ |year| (@achievement_of_school[year][assignature_id][assign_ability.id].to_i rescue 0)}.flatten
    end
  
    private
      def calculate_percent_and_level correct_ans, student_ans, all_quest
        
        if percent(correct_ans, student_ans).present?
          score = percent(correct_ans, student_ans)
        else
          score = 0
        end

        if @evaluation_type.short_name == 'simce'
          score = (score*2.05+156).to_f.round
        end
        range = @colors.where('min <= ? AND max >= ?', score, score).last
        @student_by_level[srip_and_downcase(range.nombre)] += 1 if range.present?
      end
  
      def set_student_level_and_range assignature, grade
        @student_by_level = {}
        @student_by_level['absent'] = 0
        @colors = ColorRange.assignature_level_based_evaluation(assignature, grade, @evaluation_type)
        @colors.sort_by(&:min).map{ |range| @student_by_level[srip_and_downcase(range.nombre)] = 0 }
      end
  end