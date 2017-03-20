Rails.application.routes.draw do
  get 'contact', to: 'contact#index', only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources 'products', only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'


end
