class WelcomeController < ApplicationController
	# load_and_authorize_resource
	def index
  	if current_user.has_role?(:super) || current_user.has_role?(:administrador) || current_user.has_role?(:general)
  		redirect_to users_path
  	elsif current_user.has_role?(:recaudación)
  		redirect_to orders_path
  	elsif current_user.has_role?(:evaluación)
  		redirect_to evaluations_path
  	elsif current_user.has_role?(:pruebas)
		  redirect_to admin_proccess_instruments_path
		elsif current_user.has_role?(:retros)
			redirect_to admin_proccess_instruments_path
    elsif current_user.has_school_client_role?
      redirect_to school_client_path
  	else
  		sign_out(current_user)
      session[:school_id] = nil
      redirect_to new_user_session_path
  	end
	end

end
