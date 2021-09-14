module MassInputConcern
  extend ActiveSupport::Concern

  def prepareReport(data)

    pauta = data["pauta"]

    @pauta = pauta

    respuestas = data["respuestas"]

    @respuestas = respuestas


    nombre_instrumento = data["nombre_instrumento"]
    nombre_colegio = data["nombre_colegio"]
    asignatura = data["asignatura"]
    curso = data["curso"]

    # Se cuenta el total de preguntas y se contabilizan las respuestas correctas de cada alumno.
    @correctas_alumnos, total_preguntas = get_correctas_y_total(pauta, respuestas)

    # Aca sacamos los alumnos presentes en integer.
    @alumnos_presentes = @correctas_alumnos.map { |a| 1==1 if a[2]  }.compact.length
    presentes = @alumnos_presentes

    # Aca obtenemos arrays de parametros de forma unica.
    contenidos = get_contenidos
    habilidad_pme = get_habilidad_pme
    eje = get_eje
    oa = get_oa
    sg = get_sg(pauta, respuestas, presentes)
    correctas_por_pregunta = get_correctas_por_pregunta(pauta, respuestas, presentes)
    #    preguntas_por_habilidad = get_preguntas_por_habilidad(pauta,habilidad_pme)
    logro_alumno = get_logro_por_alumno(pauta,respuestas,presentes)
    logro_alumno_por_habilidad = get_logro_alumno_por_habilidad(pauta,respuestas,habilidad_pme)


    # Esta tabla devuelve un array con [habilidad, total_preguntas, correctas, % de correctas de esa habilidad]
    analisis_habilidad_pme = get_analisis_habilidad_pme

    analisis_eje = get_analisis_eje

    # Lo mismo que el anterior pero por contenido
    analisis_contenido = get_analisis_contenido
    analisis_contenido_eje = get_analisis_contenido_eje

    # Usando analisis_contenido, dividimos el array grande en varios arrays chicos divididos por habilidad (habilidad->contenido)
    tablas_contenidos_por_habilidad = get_tablas_contenidos_por_habilidad(analisis_contenido)
    
    tablas_contenidos_por_eje = get_tablas_contenidos_por_eje(analisis_contenido_eje)

    habilidad_pme_y_oa_por_pregunta = get_habilidad_pme_y_oa_por_pregunta(correctas_por_pregunta)
    
    cuadro_alumnos_por_nivel_de_logro = get_cuadro_alumnos_por_nivel_de_logro(logro_alumno[0])
    
    cuadro_alumnos_por_habilidad_y_logro = get_cuadro_alumnos_por_habilidad_y_logro(logro_alumno_por_habilidad)
    

    # Esta parte es solamente para ir retornando informacion por JSON para poder verla en la consola del navegador a modo de debug.
    [@correctas_alumnos, # => 0
      total_preguntas, # => 1
      contenidos, # => 2
      habilidad_pme, # => 3
      eje, # => 4
      oa, # => 5
      analisis_habilidad_pme, # => 6
      analisis_contenido, # => 7
      tablas_contenidos_por_habilidad, # => 8
      correctas_por_pregunta, # => 9
      logro_alumno, # => 10
      logro_alumno_por_habilidad, # => 11 
      analisis_eje, # => 12
      sg, # => 13
      habilidad_pme_y_oa_por_pregunta, # => 14
      cuadro_alumnos_por_nivel_de_logro, # => 15,   Aca devuelve 2 arr, primero es tabla pme y el segundo es sg (simce)
      cuadro_alumnos_por_habilidad_y_logro, # => 16
      (@correctas_alumnos.length-presentes), # => 17 
      get_preguntas_por_oa, # => 18
      tablas_contenidos_por_eje, # => 19
      [ nombre_instrumento, nombre_colegio, asignatura, curso ] # => 20
    ]
    #    data
  end
  
  
  def get_correctas_y_total(pauta, respuestas)
    correctas_alumnos = []
    total_preguntas = 0

    # Aca hacemos un array con [nombre de alumno, cantidad de respuestas correctas, true si esta presente]
    respuestas.each_with_index do |r, i|
      if i > 0 # ignoramos encabezado
#        presente = (r.compact.length > 1) arr = arr.compact.reject { |h| h == "" }
        presente = ( r.compact.reject { |h| h == "" }.length > 1 )
        p r.compact
        correctas_alumnos << [r[0], 0, presente] if r[0].present?
      end
    end

    # Aca extraemos la cantidad de preguntas utilizando la pauta.
    pauta.each_with_index do |p, i|
      if i > 0 and p[0]
        total_preguntas += 1
      end
    end


    # Aca sacamos la cantidad de respuestas correctas por alumno utilizando la pauta para ver la alternativa correcta y utilizando el indice de la fila en la pauta para encontrar la columna en la hoja de respuestas (el indice de la columna de la pauta calza JUSTO con la columna de esa misma pregunta en la tabla de respuestas)
    respuestas.each_with_index do |r, i|
      if i > 0 and r[0]
        r.each_with_index do |sr, si|
          if si > 0 and sr
            if pauta[si][1].strip.upcase == sr.strip.upcase
              correctas_alumnos[i-1][1] += 1
            end
          end
        end
      end
    end
    [correctas_alumnos, total_preguntas]
  end

  #se crea array con : N° pregunta , hab pme , contenido, OA , alumnos que contestaron bien y que contestaron mal

  def get_correctas_por_pregunta(pauta, respuestas, presentes)

    correctas_por_pregunta = []
    correctas_pregunta = 0

    pauta.each_with_index do |p , i|
      if i > 0 and p[0]
        respuestas.each_with_index do |rs , ri|
          if ri > 0 and rs[0]
            if respuestas[ri][i].try(:strip).try(:upcase) == pauta[i][1].try(:strip).try(:upcase)
              correctas_pregunta += 1
            end
          end
        end
        correctas_por_pregunta << [i , correctas_pregunta, presentes-correctas_pregunta]
        correctas_pregunta = 0
      end
    end
    correctas_por_pregunta
  end
  
  def get_habilidad_pme_y_oa_por_pregunta correctas_por_pregunta
    habilidad_pme_y_oa_por_pregunta = []
    
    correctas_por_pregunta.each do |cpp|
      habilidad_pme_y_oa_por_pregunta << [ cpp[0], @pauta[cpp[0]][3], @pauta[cpp[0]][2], @pauta[cpp[0]][6], cpp[1], cpp[2] ]
    end
    
    habilidad_pme_y_oa_por_pregunta
  end
  
  def get_cuadro_alumnos_por_nivel_de_logro logro_alumno
    cuadro_logro_pme = []
    cuadro_logro_sg = []
    
    
    # Cuadro PME
    pme_ausente = []
    pme_bajo = []
    pme_medio_bajo = []
    pme_medio_alto = []
    pme_alto = []
    
    # Cuadro SG
    sg_ausente = []
    sg_insuficiente = []
    sg_elemental = []
    sg_adecuado = []
    
    
    logro_alumno.each do |la|
      if la[2]
        # pme
        case la[1]
        when 0..30
          pme_bajo << la[0]
        when 31..59
          pme_medio_bajo << la[0]
        when 60..75
          pme_medio_alto << la[0]
        when 76..100
          pme_alto << la[0]
        end
        # sg
        case la[1]
        when 0..65
          sg_insuficiente << la[0]
        when 66..77
          sg_elemental << la[0]
        when 78..100
          sg_adecuado << la[0]
        end
      else  
        pme_ausente << la[0]
        sg_ausente << la[0]
      end
    end
    
    total_pme = [pme_ausente.length, pme_bajo.length, pme_medio_bajo.length, pme_medio_alto.length, pme_alto.length]
    veces = total_pme.max

    veces.times do |i|
      cuadro_logro_pme << [ pme_ausente[i] || "", pme_bajo[i] || "", pme_medio_bajo[i] || "", pme_medio_alto[i] || "", pme_alto[i] || "" ]
    end
    
    [sg_ausente.length, sg_insuficiente.length, sg_elemental.length, sg_adecuado.length].max.times do |i|
      cuadro_logro_sg << [ sg_ausente[i] || "", sg_insuficiente[i] || "", sg_elemental[i] || "", sg_adecuado[i] || "" ]
    end
    
    [cuadro_logro_pme, cuadro_logro_sg, total_pme]
  end
  
  def get_cuadro_alumnos_por_habilidad_y_logro(logro_alumno_por_habilidad)
    cuadro_alumnos_por_habilidad_y_logro = []
    logro_alumno_por_habilidad[0].length.times do |i|
      por_habilidad = []
      logro_alumno_por_habilidad[1].each do |laph|
        por_habilidad << [laph[1], laph[i+2], laph[0]]
      end
      cuadro_alumnos_por_habilidad_y_logro << get_cuadro_alumnos_por_nivel_de_logro(por_habilidad)
    end
    cuadro_alumnos_por_habilidad_y_logro
  end
  
  def get_contenidos
    contenidos = []

    @pauta.each_with_index do |p, i|
      if p[0] and i > 0
        contenidos << p[2]
      end
    end
    contenidos.uniq
  end

  def get_habilidad_pme
    habilidad_pme = []

    @pauta.each_with_index do |p, i|
      if p[0] and i > 0
        habilidad_pme << p[3]
      end
    end
    habilidad_pme.uniq
  end

  def get_eje
    eje = []
    @pauta.each_with_index do |p, i|
      if p[0] and i > 0
        eje << p[4]
      end
    end
    eje.uniq
  end

  def get_oa
    oa = []
    @pauta.each_with_index do |p, i|
      if p[0] and i > 0
        oa << [ p[5], p[6] ]
      end
    end
    oa.uniq
  end

  def get_analisis_habilidad_pme
    habilidades = get_habilidad_pme
    tabla_analisis = []


    habilidades.each do |habilidad|
      total_preguntas = 0
      correctas = 0
      @pauta.each_with_index do |p, i|
        if p[3] == habilidad
          total_preguntas += 1
          @respuestas.each_with_index do |r, indice_respuesta|
            if indice_respuesta > 0
              if r[i].try(:strip).try(:upcase) == p[1].try(:strip).try(:upcase)
                correctas += 1
              end
            end
          end
        end
      end
      tabla_analisis << [habilidad, total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
    end
    tabla_analisis
  end

  def get_analisis_eje
    habilidades = get_eje
    tabla_analisis = []


    habilidades.each do |habilidad|
      total_preguntas = 0
      correctas = 0
      @pauta.each_with_index do |p, i|
        if p[4] == habilidad
          total_preguntas += 1
          @respuestas.each_with_index do |r, indice_respuesta|
            if indice_respuesta > 0
              if r[i].try(:strip).try(:upcase) == p[1].try(:strip).try(:upcase)
                correctas += 1
              end
            end
          end
        end
      end
      tabla_analisis << [habilidad, total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
    end
    tabla_analisis
  end

  def get_analisis_contenido
    tabla_analisis = []

    co = []
    @pauta.each_with_index do |p, i|
      co << [p[2], p[3]]  if i > 0 and p[2]
    end.uniq
    
#    contenidos = get_contenidos
    contenidos = co
    
    contenidos.each do |contenido|
      total_preguntas = 0
      correctas = 0
      habilidad = ""
      @pauta.each_with_index do |p, i|
        if p[2] == contenido[0] and p[3] == contenido[1]
          habilidad = p[3]
          total_preguntas += 1
          @respuestas.each_with_index do |r, indice_respuesta|
            if indice_respuesta > 0
              if r[i].try(:strip).try(:upcase) == p[1].try(:strip).try(:upcase)
                correctas += 1
              end
            end
          end
        end
      end
#      tabla_analisis << [habilidad, contenido, total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
      tabla_analisis << [habilidad, contenido[0], total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
    end
    p tabla_analisis
    tabla_analisis
  end
  
  def get_analisis_contenido_eje
    tabla_analisis = []

    co = []
    @pauta.each_with_index do |p, i|
      co << [p[2], p[4]]  if i > 0 and p[2]
    end.uniq
    
#    contenidos = get_contenidos
    contenidos = co
    
    contenidos.each do |contenido|
      total_preguntas = 0
      correctas = 0
      habilidad = ""
      @pauta.each_with_index do |p, i|
        if p[2] == contenido[0] and p[4] == contenido[1]
          habilidad = p[4]
          total_preguntas += 1
          @respuestas.each_with_index do |r, indice_respuesta|
            if indice_respuesta > 0
              if r[i].try(:strip).try(:upcase) == p[1].try(:strip).try(:upcase)
                correctas += 1
              end
            end
          end
        end
      end
#      tabla_analisis << [habilidad, contenido, total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
      tabla_analisis << [habilidad, contenido[0], total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
    end
    p tabla_analisis
    tabla_analisis
  end

  #obtenemos el logro de cada alumno , el promedio del curso 

  def get_logro_por_alumno(pauta,respuestas,presentes)

    sum = 0
    total_preguntas = 0
    correctas_alumno = 0
    porcentaje_personal = 0
    alumno_logro = []
    global = 0.0

    pauta.each_with_index do |p, i|
      if i > 0 and p[0]
        total_preguntas += 1
      end
    end

    respuestas.each_with_index do |r, i|
      if i > 0 and r[0]
        pauta.each_with_index do |p, pi|
          if pi > 0 and p[0]
            if pauta[pi][1] == respuestas[i][pi]
              correctas_alumno += 1
            end
          end
        end

        porcentaje_personal = (correctas_alumno*100)/total_preguntas
        alumno_logro << [r[0], porcentaje_personal, @correctas_alumnos[i-1][2]]
        global += porcentaje_personal
        correctas_alumno = 0
      end
    end
    
    

    @logro_curso = ((global/presentes).to_f).round
    
    
    #Sacar palabra
    
      case @logro_curso
        when 0..30
        nivel = "Bajo"
        when 31..59
        nivel = "Medio Bajo"
        when 60..75
        nivel= "Medio Alto"
        when 76..100
        nivel = "Alto"
        end
    
    [alumno_logro ,  @logro_curso, nivel]
  end
  
  
  def sg_mode_logro_alumnos_por_habilidad(porcentaje_irreal)
#    return 0 if porcentaje_irreal == 0
#    ((((porcentaje_irreal*2.05)+156)*100)/361.to_f).round
    porcentaje_irreal
  end
  #entrga el nombre, % de logro por cada habilidad , y el % promedio de sus habilidades
  def get_logro_alumno_por_habilidad(pauta,respuestas,habilidad_pme)

    logro_alumnos_por_habilidad = []
    respuestas.each_with_index do |r, ri|
      if ri > 0 and r[0]
        alumno_habilidad = []
        alumno_habilidad << @correctas_alumnos[ri-1][2]
        alumno_habilidad << r[0]
        habilidad_pme.each do |hpme|
          total_preguntas_habilidad = 0
          total_correctas_habilidad = 0
          pauta.each_with_index do |p, pi|
            if hpme == p[3] and pi > 0
              total_preguntas_habilidad += 1
              if p[1].try(:strip).try(:upcase) == r[pi].try(:strip).try(:upcase)
                total_correctas_habilidad += 1
              end
            end
          end
          alumno_habilidad << sg_mode_logro_alumnos_por_habilidad(((total_correctas_habilidad / total_preguntas_habilidad.to_f)*100).round)
        end
        logro_alumnos_por_habilidad << alumno_habilidad
      end
    end
    [habilidad_pme, logro_alumnos_por_habilidad] 

  end

  def get_sg(pauta,respuestas,presentes)
    logro = get_logro_por_alumno(pauta,respuestas,presentes)[1]
    sg =  ((logro*2.05)+156).round
    sg
  end
  
  #Devuelve array con OA,cant,prom correctas
  
  def get_preguntas_por_oa
    
    habilidades = get_oa
    tabla_analisis = []


    habilidades.each do |habilidad|
      total_preguntas = 0
      correctas = 0
      @pauta.each_with_index do |p, i|
        if p[6] == habilidad[1]
          total_preguntas += 1
          @respuestas.each_with_index do |r, indice_respuesta|
            if indice_respuesta > 0
              if r[i].try(:strip).try(:upcase) == p[1].try(:strip).try(:upcase)
                correctas += 1
              end
            end
          end
        end
      end
      tabla_analisis << [habilidad, total_preguntas, correctas, ((correctas/(total_preguntas.to_f*@alumnos_presentes))*100).round]
    end
    tabla_analisis
    
  end

  #para % de logro total (d.reduce(:+).to_f / d.size).round 
  # suma todos los numeros de un array , saca promedio y redondea


  #  def get_preguntas_por_habilidad(pauta,habilidad_pme)
  #
  #    
  #    habilidad_preguntas = []
  #    cantidad_preguntas = 0
  #
  #    habilidad_pme.each_with_index do |h,i|
  #      pauta.each_with_index do |pa,pi|
  #        if pi > 0 and pa
  #          if pauta[pi][3].try(:strip).try(:upcase) == h[i].try(:strip).try(:upcase)
  #            cantidad_preguntas += 1
  #          end
  #        end
  #        habilidad_preguntas << [h , cantidad_preguntas]
  #        cantidad_preguntas = 0
  #      end
  #    end
  #    habilidad_preguntas
  #  end

  def get_tablas_contenidos_por_habilidad tabla_contenidos
    # Esta funcion devuelve un array que contiene varios arrays, donde cada uno de esos arrays representa una tabla por habilidad, que contiene sus contenidos.
    tablas = []
    habilidades = get_habilidad_pme

    habilidades_contenidos = []

    @pauta.each_with_index do |p, i|
      habilidades_contenidos << [p[3], p[2]]  if i > 0 and p[2]
    end.uniq
    
    
    habilidades_contenidos.each do |habilidad, contenido|
      tabla_por_contenido = []
      tabla_contenidos.each do |row|
        if row[0] == habilidad and row[1] == contenido
#          tabla_por_contenido << row
          tablas << row
        end
      end
#      tablas << tabla_por_contenido.uniq
    end
    res = []
    
    habilidades.each do |h|
      t_por_habilidad = []
      tablas.uniq.each do |t|
        if h == t[0]
          t_por_habilidad << t
        end
      end
      res << t_por_habilidad
    end
    res
  end

  def get_tablas_contenidos_por_eje tabla_contenidos
    # Esta funcion devuelve un array que contiene varios arrays, donde cada uno de esos arrays representa una tabla por habilidad, que contiene sus contenidos.
    tablas = []
    habilidades = get_eje

    habilidades_contenidos = []

    @pauta.each_with_index do |p, i|
      habilidades_contenidos << [p[4], p[2]]  if i > 0 and p[2]
    end.uniq
    
    
    habilidades_contenidos.each do |habilidad, contenido|
      tabla_por_contenido = []
      tabla_contenidos.each do |row|
        if row[0] == habilidad and row[1] == contenido
#          tabla_por_contenido << row
          tablas << row
        end
      end
#      tablas << tabla_por_contenido.uniq
    end
    res = []
    
    habilidades.each do |h|
      t_por_habilidad = []
      tablas.uniq.each do |t|
        if h == t[0]
          t_por_habilidad << t
        end
      end
      res << t_por_habilidad
    end
    res
  end
  
end

