module UsersHelper

  def client_user_roles
    UserType.where(code: %w(DAEM UTP PROFESOR DIRECTOR COBRANZA)).map{|type| [type.name, type.id]}
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Usuario creado con éxito.'
    else
      flash[:error] = @user.errors
    end
  end

  def initialize_user
    @user = User.new
    respond_to do |format|
      format.html
      format.json { render json: ClientUserDatatable.new(view_context) }
    end
  end
end