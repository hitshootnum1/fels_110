module LessonHelper
  def correct_answer word
    WordAnswer.find_by(word_id: word.id, correct: true).content
  end
end
