class WordAnswer < ActiveRecord::Base
  belongs_to :user

  has_many :lesson_word
end
