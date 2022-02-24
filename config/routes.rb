# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root to: 'graduation_works#index'

  get '/login', to: 'sessions#new'

  resources :users, only: %i[] do
    collection do
      get 'edit'

      resource :me, me_scope: true, only: %i[] do
        resources :graduation_works, only: %i[index]
      end
    end
  end

  resources :graduation_works, only: %i[new edit show] do
    resources :reviews, only: %i[new edit]
  end

  draw(:api_v1)
end
