class Answer < ActiveRecord::Base
  belongs_to :word

  has_many :questions
  has_many :lessons, through: :questions

  validates :content, presence: true, length: {maximum: Settings.size_content}

  scope :random_index, ->{order "RANDOM()"}
end
