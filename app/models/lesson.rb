class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :activities
  has_many :lesson_words
  has_many :words, through: :lesson_words

  before_create :create_words

  private
  def create_words
    category_size = self.category.words.count
    limit = Settings.lesson.limit
    size =  limit < category_size ? limit : category_size
    self.words = self.category.words.sample size
  end
end
