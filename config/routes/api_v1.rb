# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :graduation_works, only: %i[index show create update] do
        resources :reviews, only: %i[show create update]
      end

      resources :stage_of_studies, only: %i[index]

      post :login, to: 'sessions#create'
      delete :logout, to: 'sessions#destroy'
      post :refresh_token, to: 'sessions#refresh_token'

      resources :users, only: %i[] do
        collection do
          get :me
          put :update

          resource :me, me_scope: true, only: %i[] do
            resources :graduation_works, only: %i[index]
          end
        end
      end
    end
  end
end
