class AssignedSchoolsController < ApplicationController

  def assign
    @user = User.find(params[:user_id])
    if params[:assign].present?
      if @user.has_role?(:daem)
        @user.assigned_schools.delete_all
        params[:assign].each do |id|
          @user.assigned_schools.where(school_id: id).first_or_initialize.save
        end
      else
        @user.assigned_schools.first_or_initialize.update(school_id: params[:assign])
      end
      redirect_to client_user_users_path
    end
  end

  def assigned
    user = User.find(params[:user_id])
    @assigned_schools = user.assigned_schools
  end

end
