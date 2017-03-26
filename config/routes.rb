Rails.application.routes.draw do
  get 'store/index'

  get 'category/index', to: 'category#index'

  get 'contact', to: 'contact#index', only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources 'products', only: [:index, :show]

  resources 'category', only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'store#index'

  get '/store/categorized_products', to: 'store#categorized_products'

end
