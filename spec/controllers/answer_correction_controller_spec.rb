require 'rails_helper'

RSpec.describe AnswerCorrectionsController, type: :controller do

  describe "POST create" do
    it 'user create answer_correction' do
      user = create(:user)
      question = user.questions.create(title: 'title', body: 'body')
      answer = question.answers.create(body: 'body', user_id: user.id)
      answer_correction = answer.answer_corrections.create(body: 'body', user_id: user.id)

      expect(AnswerCorrection.count).to eq 1
    end
  end

end
