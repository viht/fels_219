class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :questions
  has_many :lessons, through: :questions

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  validates :answers, length: {minimum: Settings.min_answers,
    maximum: Settings.max_answers}
  validate :just_one_answer_true

  private

  def just_one_answer_true
    if self.answers.select {|answer| answer.is_correct == true}.size !=
      Settings.true_size_answers
      errors.add :base, I18n.t("errors_answers")
    end
  end
end
