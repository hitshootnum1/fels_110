class Word < ActiveRecord::Base
  belongs_to :cagetory

  has_many :lesson_words
  has_many :word_answers
  has_many :lessons, through: :lesson_words
end
