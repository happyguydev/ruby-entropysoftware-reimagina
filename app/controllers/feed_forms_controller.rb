class FeedFormsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_feed_form, only: [:show, :edit, :update, :destroy]

  # GET /feed_forms
  # GET /feed_forms.json
  def index
    @feed_forms = FeedForm.all
  end

  # GET /feed_forms/1
  # GET /feed_forms/1.json
  def show
  end

  # GET /feed_forms/new
  def new
    @feed_form = FeedForm.new
  end

  # GET /feed_forms/1/edit
  def edit
  end

  # POST /feed_forms
  # POST /feed_forms.json
  def create
    @feed_form = FeedForm.new(feed_form_params)

    respond_to do |format|
      if @feed_form.save
        format.html { redirect_to @feed_form, notice: 'Feed form was successfully created.' }
        format.json { render :show, status: :created, location: @feed_form }
      else
        format.html { render :new }
        format.json { render json: @feed_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_forms/1
  # PATCH/PUT /feed_forms/1.json
  def update
    respond_to do |format|
      if @feed_form.update(feed_form_params)
        format.html { redirect_to @feed_form, notice: 'Feed form was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed_form }
      else
        format.html { render :edit }
        format.json { render json: @feed_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_forms/1
  # DELETE /feed_forms/1.json
  def destroy
    @feed_form.destroy
    respond_to do |format|
      format.html { redirect_to feed_forms_url, notice: 'Feed form was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed_form
      @feed_form = FeedForm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_form_params
      params.require(:feed_form).permit(:feedback_id, :feed_item_id, :feed_score_id)
    end
end
