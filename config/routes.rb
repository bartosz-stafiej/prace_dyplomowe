# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :employees
  devise_for :students, controllers: {
    registrations: 'registrations'
  }

  root to: 'home#home'

  get '/home', to: 'home#home'
end
