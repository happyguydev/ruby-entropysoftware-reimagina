class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_admin_menu
  include UsersHelper

  # GET /users
  # GET /users.json
  def index
    # User.joins(:user_type).where('user_types.role': 'admin')
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(view_context) }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Usuario creado con éxito.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'Usuario actualizado con éxito.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
    if @user.user_type.role == "admin"
      format.html { redirect_to users_url, notice: 'Usuario borrado con éxito.' }
    else
      format.html { redirect_to client_user_users_url, notice: 'Usuario borrado con éxito.' }
    end
      format.json { head :no_content }
    end
  end

  def client_user
    if params[:user].present?
      create_user
    else
      initialize_user
    end
  end

  def update_client_user
    @url = update_client_user_users_path
    @method = 'post'

    @user = if params[:id].present?
              User.find(params[:id])
            elsif params[:user][:email].present?
              User.where(email: params[:user][:email]).try(:last)
            end
    if params[:user].present?
      @user.update(user_params)
      redirect_to client_user_users_path unless @user.errors.present?
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name,:second_name, :email, :tel, :user_type_id, :password, :password_confirmation)
    end

    def set_admin_menu
      @admin_menu = true
    end
end
