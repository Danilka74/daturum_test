class AnswerCorrectionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_answer, only: [:new, :create]

  def new
    @question = Question.find(params[:question_id])
    @answer_correction = @answer.answer_corrections.new()

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@answer, partial: 'answer_corrections/form',
          locals: { answer: @answer, question: @question })
        end
      format.html
    end
  end

  def create
    @answer_correction = @answer.answer_corrections.create(answer_correction_params)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('answer_correction_form', partial: 'answer_corrections/answer_correction',
          locals: { answer_correction: @answer_correction, answer: @answer })
        end
      format.html
    end
  end

  private

  def set_answer
    if params[:answer_id].present?
      @answer = Answer.find(params[:answer_id])
    else
      @answer = Answer.find(params[:answer_correction][:answer_id])
    end
  end

  def answer_correction_params
    params.require(:answer_correction).permit(:body).merge(user: current_user)
  end
end
