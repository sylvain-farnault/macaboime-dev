class UserRolesController < ApplicationController
  def index
    @users = User.all.includes(:roles)
    @user_role = UserRole.new
  end

  def create
    @user_role = UserRole.new(user_role_params)
    if @user_role.save
      redirect_to user_roles_path, notice: "#{@user_role.user.email} est désormais #{@user_role.role.label}"
    else
      @users = User.all.includes(:roles)
      render :index, alerte: "Vérifie les infos"
    end
  end

  private

  def user_role_params
    params.require(:user_role).permit(:user_id, :role_id)
  end
end
