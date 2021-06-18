class AnswerCorrection < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :body, presence: true
  validates :user, uniqueness: { scope: :answer_id }
end
