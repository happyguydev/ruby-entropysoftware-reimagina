class AdminController < ApplicationController
  load_and_authorize_resource
  
  def index
  end

  def schools
    @admin_menu = true
    @schools = School.all
    render "schools/index"
  end

  def users
  end

  def roles
  end
end
