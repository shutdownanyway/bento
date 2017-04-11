Rails.application.routes.draw do

  devise_for :users,  path: '', path_names: { sign_in: 'login', sign_out: 'logout'},   controllers: {  registrations: "registrations" }
  get 'category/index', to: 'category#index'

  get 'contact', to: 'contact#index', only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

 resources 'products', only: [:index, :show]

  resources :store, only: [:index, :show] do #[:index, :show]
    member do #collection would be collection of customers
      post :add_to_cart #POST /customers/:id/remember_to_call/
      post :remove_from_cart
      post :update_quantity
      post :calculate_total
      post :save_profile
    #  patch :save_profile
      #post :mark_as_called #POST /customers/:id/mark_as_called/
    end
  end

  resources 'category', only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'store#index'

  get 'new_products', to: 'store#new_products'

  get 'clearance', to: 'store#sale'

  get 'updated_products', to: 'store#updated_products'

  get 'cart_list', to: 'store#cart_list'
  get 'checkout', to: 'store#checkout'
  get 'payment', to: 'store#payment'

  #patch 'store/:id/save_profile', to: 'store#save_profile'

  get 'profile', to: 'store#profile'
   devise_scope :user do
   get 'logout' => 'devise/sessions#destroy'
   patch 'store/:id/save_profile', to: 'users/registrations#update'

    resources :charges
 end
#
# devise_for :users, skip: [:sessions]
# as :user do
#   get 'signin', to: 'devise/sessions#new', as: :new_user_session
#   post 'signin', to: 'devise/sessions#create', as: :user_session
#   delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
# end
end
