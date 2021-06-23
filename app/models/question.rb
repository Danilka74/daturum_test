class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  broadcasts_to "questions"

  # after_create_commit { broadcast_append_to "questions" }
  # after_destroy_commit { broadcast_remove_to "questions" }

  validates :title, :body, presence: true
end
