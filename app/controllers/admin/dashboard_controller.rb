class Admin::DashboardController < ApplicationController
  layout "admin"

  before_action :logged_in_user
  before_action :verify_admin_user
end
