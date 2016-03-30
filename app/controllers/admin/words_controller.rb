class Admin::WordsController < ApplicationController

  before_action :logged_in_user
  before_action :admin_user

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

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
