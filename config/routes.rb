Rails.application.routes.draw do

  devise_for :admins
  root to: 'home#index'

  resources :home, only: [:index]
  resources :blogs, only: [:index, :show]
  resources :projects, only: [:index, :show]

  namespace :admin do
    resources :home, only: [:index]
    resources :blogs
    resources :projects
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
