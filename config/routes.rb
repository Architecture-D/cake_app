Rails.application.routes.draw do

   devise_for :admins

  devise_for :customers, controllers: {
    registrations: 'customers/registrations',
    sessions: 'customers/sessions'
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
    get '/products/:id', to: 'products#show'
    resource :customers,only: [:show,:index,:edit,:update,:destroy] do
      collection do
        get 'hide'
      end
    end
    resources :cart_items,only: [:create,:index,:destroy_all,:destroy,:update]
    resources :orders,only: [:new,:confirm,:create,:thank,:index,:show]
    resources :destinations,only: [:index,:create,:destroy,:edit,:update]
  end

  namespace :admin do
    get 'home/top', to: 'home#top'
    resources :customers,only: [:show,:index,:edit,:update]
    resources :genres,only: [:index,:create,:edit,:update]
    resources :products,only: [:index,:new,:create,:edit,:update,:show]
    resources :order_details,only: [:update]
    resources :orders,only: [:index,:show,:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end