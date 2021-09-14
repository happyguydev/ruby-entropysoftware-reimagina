require 'amazon_signature'

class ApplicationController < ActionController::Base
	include AmazonSignature
	include ApplicationHelper
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :authenticate_user!
	before_action :set_amazon_signature_hash
  # before_action :set_menu_bar

	protect_from_forgery with: :exception
	rescue_from CanCan::AccessDenied, with: :redirect_to_previous

	# load_and_authorize_resource
	def communes_by_region
		region = Region.find(params[:id])
		render json: region.communes.map{ |c| [c.name, c.id] }
	end
	
	private
		def redirect_to_previous
			session[:return_to] ||= request.referer
			redirect_to session.delete(:return_to)
		end



		def referer_relative_path
			hostname = request.host
			relativepath = request.referer.sub(/^#{hostname}\//, '')
			relativepath
		end

		def set_amazon_signature_hash
			@hash = AmazonSignature::data_hash
		end

	  # def set_menu_bar
	  #   if current_user.has_school_client_role?
	  #     @school_client_menu = true
	  #   else
	  #     @admin_menu = true
	  #   end
	  # end
end
