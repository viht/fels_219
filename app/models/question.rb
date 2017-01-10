class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  belongs_to :answer
  belongs_to :word

  scope :correct_anwsers, -> do
    joins(:answer).where("answers.is_correct = ?", true)
  end
  scope :fail_answers, -> do
    joins(:answer).where("answers.is_correct = ?", false)
  end
  scope :null_answers, -> {where(answer: nil)}
end
