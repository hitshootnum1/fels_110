class Admin::UsersController < ApplicationController

  before_action :logged_in_user
  before_action :admin_user
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
