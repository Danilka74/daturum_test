class AnswerCorrectionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_answer, only: [:new, :create]

  def new
    @question = Question.find(params[:question_id])
    @answer_correction = @answer.answer_corrections.new()
    authorize @answer_correction

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
    authorize @answer_correction

    respond_to do |format|
      if @answer_correction.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('answer_correction_form', partial: 'answer_corrections/answer_correction',
            locals: { answer_correction: @answer_correction, answer: @answer })
          end
        format.html
      else
        flash[:alert] = 'Ошибка'
        format.html { redirect_to root_path }
      end
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
    params.require(:answer_correction).permit(:body, :answer_id).merge(user: current_user)
  end
end
