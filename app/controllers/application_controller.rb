class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper

  protect_from_forgery with: :exception
end
