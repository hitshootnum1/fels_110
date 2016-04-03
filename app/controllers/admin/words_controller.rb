class Admin::WordsController < Admin::DashboardController

  def index
    if params[:word].present?
      content = params[:word][:content]
      if params[:word][:category_id].present?
        @category = Category.find_by id: params[:word][:category_id]
        @words = @category.words.where "content like ?", "%#{content}%"
      else
        @words = Word.where "content like ?", "%#{content}%"
      end
    end
    @words ||=  Word.all
    @words = @words.paginate page: params[:page]
    @categories = Category.all
  end

  def new
    @word = Word.new
    @categories = Category.all
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
    @word = Word.find_by id: params[:id]
    @categories = Category.all
  end

  def update
  end

  def destroy
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
