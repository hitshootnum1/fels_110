class WordAnswer < ActiveRecord::Base
  belongs_to :word

  has_many :lesson_words

  scope :correct_word, ->ids{where id: ids, correct: true}
end
