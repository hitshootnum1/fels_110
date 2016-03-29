class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "sign_up.create"
      redirect_to root_url
    else
      flash[:danger] = t "sign_up.error"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user.doesnt_exist"
      redirect_to root_url
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
