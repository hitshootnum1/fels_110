class Word < ActiveRecord::Base

  LEARN_QUERY = "id IN (SELECT word_id FROM lessons INNER JOIN lesson_words
    ON lessons.id = lesson_words.lesson_id
    WHERE lessons.user_id = ?)"

  belongs_to :cagetory

  has_many :lesson_words
  has_many :answers, class_name: WordAnswer.name
  has_many :lessons, through: :lesson_words

  accepts_nested_attributes_for :answers, allow_destroy: :true,
    reject_if: proc{|a| a[:content].blank?}

  validates :category_id, presence: true
  validates :content, presence: true
  validates :answers, presence: true
  validate :one_correct_answer

  scope :learned, ->user_id{where LEARN_QUERY, user_id}
  scope :not_learned, ->user_id{where.not LEARN_QUERY, user_id}
  scope :all_words, ->user_id{}

  private
  def one_correct_answer
    unless answers.select{|a| a.correct}.size == 1
      errors.add :base, I18n.t("word.only_one")
    end
  end
end
