class Admin::CategoriesController < Admin::DashboardController

  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :filter_category, only: :index
  before_action :load_words, only: :show

  def index
    @categories ||= Category.all
    @categories = @categories.paginate page: params[:page]
  end

  def show
  end

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

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.update_success"
      redirect_to @category
    else
      flash[:danger] = t "category.update_error"
      redirect_to root_path
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.delete_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category.delete_error"
      redirect_to root_path
    end
  end

  private
  def filter_category
    if params[:category].present?
      name = params[:category][:name]
      @categories = Category.name_like name
    end
  end

  def find_category
    @category = Category.find_by id: params[:id]
  end

  def category_params
    params.require(:category).permit :name, :title, :image
  end

  def load_words
    @words = @category.words.paginate page: params[:page]
  end
end
