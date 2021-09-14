class FeedScoresController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_feed_score, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu


  # GET /feed_scores
  # GET /feed_scores.json
  def index
    @feed_scores = FeedScore.all
    @feed_score = FeedScore.new

  end

  # GET /feed_scores/1
  # GET /feed_scores/1.json
  def show
  end

  # GET /feed_scores/new
  def new
    @feed_score = FeedScore.new
  end

  # GET /feed_scores/1/edit
  def edit
  end

  # POST /feed_scores
  # POST /feed_scores.json
  def create
    @feed_score = FeedScore.new(feed_score_params)

    respond_to do |format|
      if @feed_score.save
        format.html { redirect_to feed_scores_url, notice: 'Puntaje creado con éxito.' }
        format.json { render :show, status: :created, location: @feed_score }
      else
        format.html { render :new }
        format.json { render json: @feed_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_scores/1
  # PATCH/PUT /feed_scores/1.json
  def update
    respond_to do |format|
      if @feed_score.update(feed_score_params)
        format.html { redirect_to @feed_score, notice: 'Puntaje actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @feed_score }
      else
        format.html { render :edit }
        format.json { render json: @feed_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_scores/1
  # DELETE /feed_scores/1.json
  def destroy
    @feed_score.destroy
    respond_to do |format|
      format.html { redirect_to feed_scores_url, notice: 'Puntaje borrado con éxito.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feed_score
    @feed_score = FeedScore.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feed_score_params
    params.require(:feed_score).permit(:nombre, :score)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
