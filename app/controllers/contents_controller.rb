class ContentsController < ApplicationController
    load_and_authorize_resource
    before_action :set_admin_menu
    before_action :set_content, only: [:show, :edit, :update, :destroy]

    # GET /contents
    # GET /contents.json
    def index
        @contents = Content.all
        @content = Content.new
        respond_to do |format|
            format.html
            format.json { render json: ContentDatatable.new(view_context) }
        end
    end

    # GET /contents/1
    # GET /contents/1.json
    def show
    end

    # GET /contents/new
    def new
        @content = Content.new
    end

    # GET /contents/1/edit
    def edit
    end

    # POST /contents
    # POST /contents.json
    def create
        @content = Content.new(content_params)
        respond_to do |format|
            if @content.save
                format.html { redirect_to contents_url, notice: 'Contenido creado con éxito.' }
                format.json { render :show, status: :created, location: @content }
            else
                format.html { redirect_to contents_url, :flash => { :error => "No se pudo crear el contenido, ya existente?" } }
                format.json { render json: @content.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /contents/1
    # PATCH/PUT /contents/1.json
    def update
        #merge_contents
        respond_to do |format|
            if @content.update(content_params)
                format.html { redirect_to contents_url, notice: 'Contenido actualizado con éxito.'}
                format.json { render :show, status: :ok, location: @content }
            else
                format.html { render :edit }
                format.json { render json: @content.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /contents/1
    # DELETE /contents/1.json
    def destroy
        @content.destroy
        respond_to do |format|
            format.html { redirect_to contents_url, notice: 'Contenido borrado con éxito.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
        @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
        params.require(:content).permit(:nombre, :descripcion, :assignature_id)
    end

    def set_admin_menu
        @admin_menu = true
    end
end
