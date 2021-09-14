class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role?(:super)
      can :manage, :all
    end

    if user.try(:user_type).try(:role).eql?("admin")
      type = user.user_type.code.try(:downcase).try(:to_sym)
      case type
      when :administrador
        administrador_abilities(user)
      when :general
        general_abilities(user)
      when :recaudacion
        recaudación_abilities(user)
      when :evaluacion
        evaluación_abilities(user)
      when :pruebas
        pruebas_abilities(user)
      when :retros
        retros_abilities(user)
      when :utp
        utp_abilities(user)
      when :profesor
        profesor_abilities(user)
      when :director
        director_abilities(user)
      when :daem
        daem_abilities(user)
      end
      school_client_abilities(user) if user.has_school_client_role?
    elsif user.try(:user_type).try(:role).eql?("client")
      type = user.user_type.code.try(:downcase).try(:to_sym)
      case type
        when :utp
          utp_abilities(user)
        when :profesor
          profesor_abilities(user)
        when :director
          director_abilities(user)
        when :daem
          daem_abilities(user)
        when :cobranza
          cobranza_abilities(user)
        end
      school_client_abilities(user) if user.has_school_client_role?
    end
  end

  def administrador_abilities(user)
    can :manage, :all
  end

  def evaluación_abilities(user)
    can :manage, Question
    can :manage, Answer
    can :manage, Alternative
    can :manage, Evaluation
    can :manage, EvaluationType
    can :manage, GroupQuestion
  end

  def general_abilities(user)
    can :read, :all
    can :manage, :comparative
    can :manage, Instrument
    can :client_user, User
    can :admin, ProccessInstrument

  end

  def pruebas_abilities(user)
    can :admin, ProccessInstrument
    can :read, ProccessInstrument
    can :manage, :comparative
    can :read, Instrument
  end

  def retros_abilities(user)
    can :admin, ProccessInstrument
    can :manage, :comparative
  end

  def recaudación_abilities(user)
    can :read, Order
    can :cobranza, Order
    can :manage, OrderStatus
    can :manage, Invoice
    can :manage, BuyOrder
    can :manage, FeedScore
    can :read, FeedItem
    can :manage, Feedback
    can :manage, FeedForm
  end

  #Client users

  def school_client_abilities(user)
    can :read, School, :assigned_schools => { :user_id => user.id }
  end

  def cobranza_abilities(user)
    can :read, Invoice
    can :read, BuyOrder
  end

  def utp_abilities(user)
    can :manage, Student
    can :read, Grade
    can :manage, Answer
    can :read, ProccessInstrument
    can :manage, :comparative
    can :read, Instrument
  end

  def profesor_abilities(user)
    can :manage, Student
    can :manage, Answer
    can :read, Instrument
    can :read, Result
    can :read, School
    can :read, Grade
  end

  def daem_abilities(user)
    can :read, Student
    can :read, Grade
    can :read, ProccessInstrument
    can :manage, Answer
    can :read, Instrument
    can :read, Result
    can :manage, :comparative
  end

  def director_abilities(user)
    can :manage, Student
    can :read, Grade
    can :read, Instrument
    can :read, Result
    can :manage, Answer
    can :read, ProccessInstrument
    can :manage, :comparative
    can :read, Instrument
  end
end
