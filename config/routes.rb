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

  resources :raports, only: %i[index new create] do
    collection do
      post 'generate_csv'
    end
  end

  resources :graduation_works, only: %i[edit index show update create delete] do
    resources :reviews, only: %i[index show new edit update create delete]

    resources :thesis_defenses, only: %i[show index new create edit update delete]
  end

  draw(:api_v1)
end
