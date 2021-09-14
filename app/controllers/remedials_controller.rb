class RemedialsController < ApplicationController
    load_and_authorize_resource

    before_action :set_remedial, only: [:show, :edit, :update, :destroy]
    before_action :set_admin_menu

    # GET /remedials
    # GET /remedials.json
    def index
      @remedials = Remedial.all
      @remedial = Remedial.new

      respond_to do |format|
          format.html
          format.json { render json: RemedialDatatable.new(view_context) }
      end
    end

    # GET /remedials/1
    # GET /remedials/1.json
    def show
    end

    # GET /remedials/new
    def new
        @remedial = Remedial.new
    end

    # GET /remedials/1/edit
    def edit
    end

    # POST /remedials
    # POST /remedials.json
    def create
        @remedial = Remedial.new(remedial_params)

        respond_to do |format|
            if @remedial.save
                format.html { redirect_to remedials_url, notice: 'Remedial creado con éxito.' }
                format.json { render :show, status: :created, location: @remedial }
            else
                format.html { render :new }
                format.json { render json: @remedial.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /remedials/1
    # PATCH/PUT /remedials/1.json
    def update
        respond_to do |format|
            if @remedial.update(remedial_params)
                format.html { redirect_to remedials_url, notice: 'Remedial actualizado con éxito.' }
                format.json { render :show, status: :ok, location: @remedial }
            else
                format.html { render :edit }
                format.json { render json: @remedial.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /remedials/1
    # DELETE /remedials/1.json
    def destroy
        @remedial.destroy
        respond_to do |format|
            format.html { redirect_to remedials_url, notice: 'Remedial borrado con éxito.' }
            format.json { head :no_content }
        end
    end

    def get_content
      assignature_id =  params[:assignature]
      @data = Assignature.find(assignature_id).contents.collect{|content| [content.nombre,content.id]}.unshift(['Seleccione una opcion', nil])
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_remedial
        @remedial = Remedial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remedial_params
        params.require(:remedial).permit(:nombre, :content_id, :level_id)
    end

    def set_admin_menu
        @admin_menu = true
    end
end
