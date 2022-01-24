# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees
  devise_for :students

  root to: 'graduation_works#index'

  resources :raports, only: %i[index new create] do
    collection do
      post 'generate_csv'
    end
  end

  resources :graduation_works, only: %i[edit index show update create delete] do
    resources :reviews, only: %i[index show new edit update create delete]

    resources :thesis_defenses, only: %i[show index new create edit update delete]
  end

  resources :students, only: %i[] do
    collection do
      resource :me, me_scope: true, only: %i[] do
        resources :graduation_works, only: %i[new index]
      end
    end
  end

  draw(:api_v1)
end
