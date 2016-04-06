class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :check_namespace

  private
  def check_namespace
    if logged_in?
      path = controller_path
      admin_not_allowed = ["lessons", "words", "categories"]
      if path.start_with? "admin"
        verify_admin_user
      elsif admin_not_allowed.include? path
        verify_normal_user
      elsif path == "users" && action_name == "index"
        verify_normal_user
      end
    end
  end
end
