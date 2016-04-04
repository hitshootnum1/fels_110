class User::CategoriesController < User::DashboardController

  before_action :logged_in_user

  def index
    @categories = Category.paginate page: params[:page]
  end

  def show
    @category = Category.find_by id: params[:id]
  end
end
