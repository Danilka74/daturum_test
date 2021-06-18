class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @questions = Question.all
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.create(question_params)

    respond_to do |format|
      if @question.save
        flash[:success] = 'Успешно'
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
