class AnswerCorrectionPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    user.present?
  end

  private

  def answer_correction
    record
  end
end
