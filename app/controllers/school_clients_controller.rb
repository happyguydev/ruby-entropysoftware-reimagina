class SchoolClientsController < ApplicationController
  before_action :set_user
  before_action :set_school, except: [:enter_to_school]
  before_action :set_school_client_menu

  def assigned_school
    if @user.has_role?(:daem)
      @assigned_schools = @user.assigned_schools
    else
      school_id = @user.assigned_schools.try(:first).try(:school_id)
      redirect_to school_path(id:school_id)
    end
  end

  def billing
    @payments = @school.try(:orders).collect(&:payments).try(:flatten)

    respond_to do |format|
      format.html
      format.json { render json: SchoolBillingDatatable.new(view_context, payment_ids: @payments.collect(&:id)) }
    end
  end

  def contact_us
    if params[:contact].present?
      @contact = Contact.create(contact_params)
      if @contact.save
        flash[:success] = 'Thanks for contacting us!'
      else
        flash[:error] = @contact.errors
      end
    else
      @contact = Contact.new
    end
  end

  def edit_profile
    if params[:user].present?
      if @user.update(user_params)
        flash[:notice] = 'Usuario actualizado con éxito.'
      else
        flash[:error] = @user.errors
      end
    end
  end

  def enter_to_school
    session[:school_id] = params[:school_id]
    redirect_to school_client_path
  end

  def evaluation
    respond_to do |format|
      format.html
      format.json { render json: SchoolEvaluationDatatable.new(view_context, school_id: @school.try(:id)) }
    end
  end

  def feedback
    @order = @school.orders.last

    if @order.feedback.present?
      @msg = 'Ya has enviado tu formulario de satisfacción para esta orden. Podrás evaluarnos nuevamente en tu próximo año de servicio.'
    else
      @feedback = @order.try(:build_feedback)
    end
  end

  def invoice
    @invoices = @school.try(:orders).collect(&:invoices).try(:flatten)

    respond_to do |format|
      format.html
      format.json { render json: SchoolInvoiceDatatable.new(view_context, invoice_ids: @invoices.collect(&:id)) }
    end
  end

  def results_n_reports
    respond_to do |format|
      format.html
      format.json { render json: SchoolReportDatatable.new(view_context, school_id: @school.id) }
    end
  end

  def update_feedback
    @order = @school.orders.last
    @feedback = @order.build_feedback

    if params[:feedback].present?
      @feedback.update(feedback_params)
      params[:feed].values.each do |feed|
        @feedback.feed_forms.create(feed_item_id: feed[:item], feed_score_id: get_feed_score_id(feed[:score].to_i))
      end
      flash[:success] = 'Feedback enviado exitosamente'
      redirect_to :back
    end
  end

  def view_order
    @order_invoice = Payment.find(params[:payment_id]).try(:order).try(:invoice)
  end

  private
    def contact_params
      params.require(:contact).permit(:contact, :email, :message, :name, :subject, :school_id, :user_id)
    end

    def feedback_params
      params.require(:feedback).permit(:comentario, :score)
    end

    def get_feed_score_id rating
      score = case rating
                when 1 then 0
                when 2 then 25
                when 3 then 50
                when 4 then 75
                when 5 then 100
                end
      feed_score_id = FeedScore.where(score: score).try(:last).try(:id)
    end

    def set_school
      if current_user.has_role?(:daem)
        if session[:school_id].present?
          @school = School.find(session[:school_id]) rescue (session[:school_id] = nil)
        else
          @assigned_schools = current_user.assigned_schools
        end
      else
        @school = @user.assigned_schools.try(:first).try(:school)
      end
    end

    def set_school_client_menu
      @school_client_menu = true
    end

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:first_name,:second_name, :email, :user_type_id, :password, :password_confirmation)
    end
end
