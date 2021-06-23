class QuestionPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  private

  def question
    record
  end
end
