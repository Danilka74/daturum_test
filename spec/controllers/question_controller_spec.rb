require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe "GET index" do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    it 'user create question' do
      user = create(:user)
      question = user.questions.create(title: 'title', body: 'body')
      expect(Question.count).to eq 1
    end
  end

end
