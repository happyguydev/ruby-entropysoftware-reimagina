class FeedItemsController < ApplicationController
  load_and_authorize_resource
  
  before_action :set_feed_item, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu


  # GET /feed_items
  # GET /feed_items.json
  def index
    @feed_items = FeedItem.all
    @feed_item = FeedItem.new

  end

  # GET /feed_items/1
  # GET /feed_items/1.json
  def show
  end

  # GET /feed_items/new
  def new
    @feed_item = FeedItem.new
  end

  # GET /feed_items/1/edit
  def edit
  end

  # POST /feed_items
  # POST /feed_items.json
  def create
    @feed_item = FeedItem.new(feed_item_params)

    respond_to do |format|
      if @feed_item.save
        format.html { redirect_to feed_items_url, notice: 'Ítem creado con éxito.' }
        format.json { render :show, status: :created, location: @feed_item }
      else
        format.html { render :new }
        format.json { render json: @feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feed_items/1
  # PATCH/PUT /feed_items/1.json
  def update
    respond_to do |format|
      if @feed_item.update(feed_item_params)
        format.html { redirect_to @feed_item, notice: 'Ítem actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @feed_item }
      else
        format.html { render :edit }
        format.json { render json: @feed_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feed_items/1
  # DELETE /feed_items/1.json
  def destroy
    @feed_item.destroy
    respond_to do |format|
      format.html { redirect_to feed_items_url, notice: 'Ítem borrado con éxito' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feed_item
    @feed_item = FeedItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feed_item_params
    params.require(:feed_item).permit(:nombre)
  end

  def set_admin_menu
    @admin_menu = true
  end
end
