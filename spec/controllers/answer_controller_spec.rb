require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe "POST create" do
    it 'user create answer' do
      user = create(:user)
      question = user.questions.create(title: 'title', body: 'body')
      answer = question.answers.create(body: 'body', user_id: user.id)

      expect(Answer.count).to eq 1
    end
  end

end
