class Admin::CategoriesController < ApplicationController

  before_action :logged_in_user
  before_action :admin_user

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category.created"
      redirect_to root_path
    else
      flash[:success] = t "category.created_error"
      redirect_to root_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :title, :image
  end
end