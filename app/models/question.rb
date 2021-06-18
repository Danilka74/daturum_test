class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  after_create_commit { broadcast_append_to "questions" }

  validates :title, :body, presence: true
end
