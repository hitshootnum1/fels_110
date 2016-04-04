class StaticPagesController < ApplicationController

  before_action :role_user_redirect, only: :home

  def home
  end

  def help
  end

  private
  def role_user_redirect
    @user = current_user
    redirect_to user_path @user if normal_user?
    redirect_to admin_path if admin_user?
  end
end
