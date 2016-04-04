class Admin::WordsController < Admin::DashboardController

  before_action :filter_words, only: :index
  before_action :find_word, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:index, :new, :edit]

  def index
    @words ||=  Word.all
    @words = @words.paginate page: params[:page]
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "word.create"
      redirect_to root_path
    else
      flash[:danger] = t "word.not_create"
      redirect_to new_admin_word_path
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "word.update_success"
      redirect_to admin_words_path
    else
      flash[:danger] = t "word.update_error"
      redirect_to root_path
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "word.delete_success"
      redirect_to admin_words_path
    else
      flash[:danger] = t "word.delete_error"
      redirect_to root_path
    end
  end

  private
  def load_categories
    @categories = Category.all
  end

  def find_word
    @word = Word.find_by id: params[:id]
  end

  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:id, :content, :correct, :_destroy]
  end

  def filter_words
    if params[:word].present?
      content = params[:word][:content]
      if params[:word][:category_id].present?
        @category = Category.find_by id: params[:word][:category_id]
        @words = @category.words.content_like content
      else
        @words = Word.content_like content
      end
    end
  end
end
