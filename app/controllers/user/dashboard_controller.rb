class User::DashboardController < ApplicationController

  before_action :logged_in_user
  before_action :normal_user

  def index
    redirect_to user_user_path(current_user)
  end
end
