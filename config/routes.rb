# frozen_string_literal: true

Rails.application.routes.draw do
  resources :groups, only: [:index, :new, :create] do
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#index"
end
