# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  # get '/articles', to: 'articles#index'
  # get '/articles/:id', to: 'articles#show'

  resources :articles, only: [:index, :show]
end
