class Admin::UsersController < Admin::DashboardController

  before_action :find_user

  def destroy
    if @user.destroy
      flash[:info] = t "user.deleted"
      redirect_to users_path
    else
      flash[:danger] = t "user.deleted_error"
      redirect_to users_path
    end
  end
end
