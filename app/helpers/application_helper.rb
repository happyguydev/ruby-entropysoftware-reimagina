module ApplicationHelper

  def active_link? field
    field == params[:action].to_sym ? "active" : ''
  end

  def percent score, total
      total.present? ? (((score.count * 100 / total.count.to_f)).round rescue 0) : nil
  end

  def srip_and_downcase object
    object.try(:downcase).try(:strip)
  end

  def set_colors_hab(pme)
    Result.set_colors(@student_results,@students,@proccess_instrument,@total_preguntas,pme,@ranking_hab)
  end

  def to_porcentaje(puntaje)
    porcentaje = Result.to_porcentaje(puntaje,@instrument)
    porcentaje
  end

  def alternative_index(char)
    case char.upcase
      when 'A' then 0
      when 'B' then 1
      when 'C' then 2
      when 'D' then 3
      when 'E' then 4
      when 'F' then 5
      when 'G' then 6
      when 'H' then 7
      when 'I' then 8
      when 'J' then 9
    end
  end

  def alphabet(int)
    case int
      when 0 then 'A'
      when 1 then 'B'
      when 2 then 'C'
      when 3 then 'D'
      when 4 then 'E'
      when 5 then 'F'
      when 6 then 'G'
      when 7 then 'H'
      when 8 then 'I'
      when 9 then 'J'
    end
  end

  def is_question_edited(question)
    question.texto != "" ? "edited" : nil
  end

  def flash_class(level)
        case level
        when 'notice' then "alert alert-info"
        when 'success' then "alert alert-success"
        when 'error' then "alert alert-error"
        when 'alert' then "alert alert-error"
        end
      end

end
