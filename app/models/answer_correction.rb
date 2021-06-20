class AnswerCorrection < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :body, presence: true
  validates :accepted_body, presence: true
  validates :user, uniqueness: { scope: :answer_id }

  scope :accepted, -> { where.not(accepted_body: nil) }

  def owner?(user_id)
    self.user_id == user_id
  end

  def unite
    [answer.body, body].join(' ')
  end
end
