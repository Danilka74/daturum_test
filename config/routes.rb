Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users

  resources :questions, only: [:index, :new, :create] do
    resource :answers, only: [:new, :create] do
      resource :answer_correction, only: [:new, :create]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
