Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users

  resources :questions, only: [:index, :create] do
    resource :answers, only: [:create, :update] do
      resource :answer_correction, only: [:create]
    end
  end

  # custom routes (needed for turbo_stream)
  post 'question/new', to: 'questions#new'
  post 'answer/new', to: 'answers#new'
  post 'answer/edit', to: 'answers#edit'
  post 'answer-correction/new', to: 'answer_corrections#new'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
