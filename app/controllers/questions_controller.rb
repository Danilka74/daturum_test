class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    authorize @question

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('question_button', partial: 'questions/form',
          locals: { question: @question })
      end
      format.html
    end
  end

  def create
    @question = current_user.questions.create(question_params)
    authorize @question

    respond_to do |format|
      if @question.save
        flash[:success] = 'Успешно'
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace('new_question_form', partial: 'questions/button')
        }
        format.html { redirect_to root_path }
      else
        flash[:alert] = 'Ошибка'
        format.html { redirect_to root_path }
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
