class StaticPagesController < ApplicationController

  before_action :home_page, only: :home

  def home
  end

  def help
  end
end
