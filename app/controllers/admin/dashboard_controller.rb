class Admin::DashboardController < ApplicationController
  layout "admin"

  before_action :logged_in_user
  before_action :admin_user

  def index
    redirect_to admin_categories_path
  end
end
