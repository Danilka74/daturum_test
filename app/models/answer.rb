class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :answer_corrections, dependent: :destroy

  validates :body, presence: true

  def owner?(user_id)
    self.user_id == user_id
  end

  def find_changes(text)
    text.gsub(body, "").strip
  end
end
