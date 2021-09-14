class FeedbacksController < ApplicationController
    # load_and_authorize_resource
    
    before_action :set_feedback, only: [:show, :edit, :update, :destroy]
    before_action :set_admin_menu

    # GET /feedbacks
    # GET /feedbacks.json
    def index
        @feedbacks = Feedback.all
        @feed_items = FeedItem.all
        @feedback = Feedback.new

        respond_to do |format|
            format.html
            format.json { render json: FeedbackDatatable.new(view_context) }
        end
    end

    # GET /feedbacks/1
    # GET /feedbacks/1.json
    def show
    end

    # GET /feedbacks/new
    def new
      @feedback = Feedback.new
    end

    # GET /feedbacks/1/edit
    def edit
    end

    # POST /feedbacks
    # POST /feedbacks.json
    def create
      @feedback = Feedback.new(feedback_params)
      respond_to do |format|
        if @feedback.save
          params[:feedback][:feed_form].each do |k, v|
            p v
            p "#######"
            @feedback.feed_forms.create(feed_item: FeedItem.where(nombre: k).first, feed_score: FeedScore.where(nombre: v).first)
          end
          format.html { redirect_to feedbacks_url, notice: 'Feedback creado con éxito.' }
          format.json { render :show, status: :created, location: @feedback }
        else
          format.html { render :index }
          format.json { render json: @feedback.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /feedbacks/1
    # PATCH/PUT /feedbacks/1.json
    def update
        respond_to do |format|
            if @feedback.update(feedback_params)
              format.html { redirect_to feedbacks_url, notice: 'Feedback actualizado con éxito.' }
                format.json { render :show, status: :ok, location: @feedback }
            else
                format.html { render :edit }
                format.json { render json: @feedback.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /feedbacks/1
    # DELETE /feedbacks/1.json
    def destroy
        @feedback.destroy
        respond_to do |format|
          format.html { redirect_to feedbacks_url, notice: 'Feedback eliminado con éxito.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
        @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:order_id, :comentario)
    end

    def set_admin_menu
        @admin_menu = true
    end
end
