Rails.application.routes.draw do
  devise_for :users

  root 'users#top'
  resources :books, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :users, only: [:show, :index, :top, :about, :edit, :update]
  get "home/about",to: "users#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
