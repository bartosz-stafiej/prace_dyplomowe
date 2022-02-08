# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :graduation_works, only: %i[index show]

      resources :users, only: %i[] do
        collection do
          get :me

          resource :me, me_scope: true, only: %i[] do
          end
        end
      end
    end
  end
end
