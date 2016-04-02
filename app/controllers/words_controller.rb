class WordsController < ApplicationController

  def index
    if params[:word].present?
      @filter = params[:word][:filter] ||= Settings.word_filter.last
      if params[:word][:category_id].blank?
        @words = Word.send @filter, current_user.id
      else
        @category = Category.find_by id: params[:word][:category_id]
        @words = @category.words.send @filter, current_user.id
      end
    end
    @words ||=  Word.all
    @words = @words.paginate page: params[:page]
    @categories = Category.all
  end
end
