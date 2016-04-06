class WordsController < ApplicationController

  before_action :logged_in_user
  before_action :filter_words, only: :index

  def index
    @words ||=  Word.all
    @words = @words.paginate page: params[:page]
    @categories = Category.all
  end

  private
  def filter_words
    if params[:word].present?
      @filter = params[:word][:filter] ||= Settings.word_filter.last
      if params[:word][:category_id].blank?
        @words = Word.send @filter, current_user.id
      else
        @category = Category.find_by id: params[:word][:category_id]
        @words = @category.words.send @filter, current_user.id
      end
    end
    filter_title
  end

  def filter_title
    @filter_name = @filter ? @filter : t("word.filter.all_words")
    @category_name = @category ? @category.name : t("category.all")
    @word = Word.new
    @word.category_id = @category.id if @category
    @word.filter = @filter ? @filter : Settings.word_filter.last
  end
end
