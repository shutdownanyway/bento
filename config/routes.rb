Rails.application.routes.draw do

  get 'category/index', to: 'category#index'

  get 'contact', to: 'contact#index', only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources 'products', only: [:index, :show]

  resources 'category', only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'store#index'

  get 'new_products', to: 'store#new_products'

  get 'clearance', to: 'store#sale'

  get 'updated_products', to: 'store#updated_products'
end
