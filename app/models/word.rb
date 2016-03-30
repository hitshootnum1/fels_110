class Word < ActiveRecord::Base
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

  private
  def one_correct_answer
    unless answers.select{|a| a.correct}.size == 1
      errors.add :base, I18n.t("word.only_one")
    end
  end
end
