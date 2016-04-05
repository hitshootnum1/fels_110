class CategoriesController < ApplicationController

  before_action :logged_in_user
  before_action :trivial_user

  def index
    @categories = Category.paginate page: params[:page]
  end

  def show
    @category = Category.find_by id: params[:id]
  end
end
