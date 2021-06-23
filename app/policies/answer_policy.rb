class AnswerPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user.present?
  end

  def update?
    return true if user.present?
  end

  def edit?
    update?
  end

  private

  def answer
    record
  end
end
