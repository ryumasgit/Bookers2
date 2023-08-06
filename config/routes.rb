Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]

  get '/home/about', to: 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
