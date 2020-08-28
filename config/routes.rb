Rails.application.routes.draw do

  devise_for :admins, :controllers => {
    :sessions => 'admins/sessions'
  }

  # devise_for :customers, skip: [:registration]
  #  devise_scope :customers do
  #    get 'customers/sign_up', to: 'devise/registrations#new', as: 'new_customer_registration'
  #    post 'customers', to:'devise/registrations#create', as: 'customer_registration'
  # end

  scope module: :customers do
    root 'home#top'
    get 'home/about', to: 'home#about'
    get '/products', to: 'products#index'
    get '/products/:id', to: 'products#show', as: 'product'
    delete 'cart_items', to: 'cart_items#destroy_all'
    resource :customers,only: [:show,:index] do
      collection do
        get 'hide'
        get 'edit_info'
        patch 'update_info'
        put 'withdrawal'
      end
    end
    resources :cart_items,only: [:create,:index,:destroy_all,:destroy,:update]
    resources :orders,only: [:new,:create,:index,:show] do
      collection do
        post 'confirm'
        get 'confirm', to:'orders#new'
        get 'thank'
      end
    end
    resources :destinations,only: [:index,:create,:destroy,:edit,:update]
  end

  namespace :admin do
    root 'home#top'
    resources :customers,only: [:show,:index,:edit,:update]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :products,only: [:index,:new,:create,:edit,:update,:show]
    resources :order_products,only: [:update]
    resources :orders,only: [:index,:show,:update]
  end

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions',
    passwords: 'customers/passwords'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
