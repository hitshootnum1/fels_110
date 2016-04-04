class Admin::DashboardController < ApplicationController
  layout "admin"

  before_action :logged_in_user
  before_action :admin_user

  def index
  end
end
