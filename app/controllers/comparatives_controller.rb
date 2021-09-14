class ComparativesController < ApplicationController
  authorize_resource :class => false
  before_action :set_school, only: [:index, :compare_report]
  before_action :set_admin_menu, only: [:index, :compare_report]

  include ComparativesHelper

  def index
    @report = params[:report]
    comparative_school
    get_daem_user
  end

  def compare_report
    if params[:report] == '6'
      params[:report] = '5'
    end

    if params[:report] == '8'
      params[:report] = '7'
    end

    if params[:report] == '9'
      params[:report] = '8'
    end

    if params[:report] == '10'
      params[:report] = '9'
    end
    GenerateComparativeJob.set(wait: 5.seconds).perform_later(params, current_user.id)
    flash[:notice] = 'Generando Informe'
    redirect_to :back
  end

  def filter_date
    default_value = ['Seleccione opcion', nil]    
    @years = School.includes(:orders).joins(orders: { proccesses: { proc_type: :proc_type_father } }).where('proc_type_fathers.short_name': REPORT_TYPES[params[:report].to_i - 1]).uniq.map { |school| school.orders.map(&:year) }.flatten.uniq.sort
    @years.unshift(default_value)
  end

  def filter_school
    default_value = ['Seleccione opcion', nil]
    @schools = School.includes(:orders).joins(orders: { proccesses: { proc_type: :proc_type_father} }).where('proc_type_fathers.short_name': REPORT_TYPES[params[:report].to_i - 1], 'orders.year': params[:year] ).uniq.map {|school| ["RBD #{school.rbd} - #{school.nombre}", school.id ] }.sort
    @schools.unshift(default_value)
  end

  def filter_user
    @users = (User.with_role :daem).collect{ |user| [user.full_name, user.id] if user.assigned_schools.count > 0 }.unshift(['Seleccione usuario DAEM', nil])
  end

  def filter_proccess
    default_value = ['Seleccione opcion', nil]
    school_ids = []
    if params[:user].present?
      user = User.find(params[:user])
      school_ids = user.assigned_schools.map(&:school_id)
    elsif params[:school].present?
      school_ids.push(params[:school])
    end
    @proccesses = Proccess.joins(proc_type: :proc_type_father).joins(order: :school).where('proc_type_fathers.short_name = ? AND orders.year = ? AND schools.id in (?)' , REPORT_TYPES[params[:report].to_i - 1], params[:year], school_ids).uniq.map{|procc| procc.proc_type.nombre }.compact.uniq.sort
    @proccesses.unshift(default_value)
  end

  private

    def comparative_params
      params.permit(:evaluation_type, :report, :school, :starting_year, :ending_year)
    end

    def comparative_school
      @comparative_school = if current_user.user_type.role.eql?('admin') || current_user.has_role?(:daem)
                            School.find(params[:school_id]) if params[:school_id].present?
                          else
                            @school
                          end
    end

    def get_daem_user
      @daem_user =  if current_user.user_type.role.eql?('admin')
                      User.find(params[:daem_user_id]) if params[:daem_user_id].present?
                    elsif current_user.user_type.role.eql?('client')
                      current_user
                    end
    end


    def set_admin_menu
      if current_user.user_type.role.eql?('client')
        @school_client_menu = true
      else
        @admin_menu = true
      end
    end

    def set_instrument
      @proccess_instrument = ProccessInstrument.last
      @instrument = @proccess_instrument.instrument
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
# grade
# report_pdf