class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_question, only: [:new, :create, :edit, :update]

  def new
    @answer = @question.answers.new()

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@question, partial: 'answers/form',
          locals: { question: @question })
      end
      format.html
    end
  end

  def create
    @answer = @question.answers.create(answer_params)

    respond_to do |format|
      if @answer.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('answer_form', partial: 'answers/answer',
            locals: { answer: @answer, question: @question })
        end
        format.html { redirect_to root_parh }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @answer = Answer.find(params[:answer_id])
    @answer_correction = AnswerCorrection.find(params[:answer_correction])
    @text_with_correction = @answer_correction.unite

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(@answer_correction, partial: 'answers/form_with_correction',
          locals: { question: @question, text_with_correction: @text_with_correction, answer_correction_id: @answer_correction.id })
      end
      format.html
    end
  end

  def update
    answer_correction = AnswerCorrection.find(params[:answer][:answer_correction_id])
    answer = answer_correction.answer

    new_answer_body = answer_params[:body]
    accepted_changes = answer.find_changes(new_answer_body)

    # rollback if answer_correction do not save
    ActiveRecord::Base.transaction do
      answer.update(answer_params)
      answer_correction.update(accepted_body: accepted_changes)
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("answer_#{answer.id}_pure", partial: 'answers/answer',
          locals: { answer: answer, question: @question })
      end
      format.html
    end

  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body).merge(user: current_user)
  end

end
