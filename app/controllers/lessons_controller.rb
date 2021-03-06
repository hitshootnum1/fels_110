class LessonsController < ApplicationController

  before_action :logged_in_user
  before_action :find_category, only: :create
  before_action :find_lesson, only: [:show, :update]
  before_action :correct_lesson, only: [:show, :update]

  def create
    @lesson = current_user.lessons.new category_id: @category.id
    if @lesson.save
      flash[:success] = t "lesson.create"
      redirect_to @lesson
    else
      flash[:danger] = t "lesson.not_create"
      redirect_to root_url
    end
  end

  def show
    if @lesson.result?
      @disable_check = true
      @answer_ids = @lesson.answer_ids
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "lesson.success"
      redirect_to @lesson
    else
      flash[:danger] = t "lesson.danger"
      redirect_to root_url
    end
  end

  private
  def correct_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless current_user? @lesson.user
      flash[:danger] = t "user.isnt_authorized"
      redirect_to root_path
    end
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "lesson.not_found"
      redirect_to root_url
    end
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "category.not_found"
      redirect_to categories_path
    end
  end

  def lesson_params
    params.require(:lesson).permit lesson_words_attributes: [:id, :word_answer_id]
  end
end

