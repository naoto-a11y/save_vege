Rails.application.routes.draw do
 
  namespace :farmer do
    get 'reservations/index'
  end
  devise_for :customers,skip: [:password], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  root to: 'homes#top'
  get 'about', to: "homes#about"


  scope module: :public do
    
    resources :items, only: [:index, :show] do
      resources :comments,   only: [:create, :destroy]
      resources :reservations, only: [:create, :index]
    end

    post 'reservations/confirm',          to: "reservations#confirm"
    get  'reservations/thanks',           to: "reservations#thanks"

    get    'customers/my_page',          to: "customers#show"
    get    'customers/information/edit', to: "customers#edit"
    patch  'customers/information',      to: "customers#update"
    get    'customers/unsubscribe',      to: "customers#unsubscribe"
    patch  'customers/withdraw',         to: "customers#withdraw"
    delete 'customers/reservations/:id', to: "customers#cancel_reservations"


    resources :farmers, path: "customer_farmers", only: [:show] do
      resource :follow,    only: [:create, :destroy, :show]
    end
    resources :tags,       only: [:index]
    resources :favorites,  only: [:create, :destroy]
    resources :dm_rooms,   only: [:show] do
      resources :dm_messages, only: [:create, :destroy]
    end
  end

  devise_for :farmers,skip: [:passwords], controllers: {
    registrations: "farmer/registrations",
    sessions: 'farmer/sessions'
  }

  namespace :farmer do
    get 'about', to: "homes#about"

    resources :items,   only: [:new, :show, :edit, :update, :destroy, :create] do
      resources :comments,   only: [:create, :destroy]
    end
    resources :reservations, only: [:index]

    get    'farmers/mypage',           to: "farmers#show"
    get    'farmers/information/edit', to: "farmers#edit"
    patch  'farmers/information',      to: "farmers#update"
    get    'farmers/unsubscribe',      to: "farmers#unsubscribe"
    patch  'farmers/withdraw',         to: "farmers#withdraw"   
    delete 'farmers/reservations/:id',        to: "farmers#cancel_reservations"
    
    resources :dm_rooms,   only: [:show] do
      resources :dm_messages, only: [:create, :destroy]
    end
    
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :customers, only: [:index, :show, :update]
    resources :farmers,   only: [:index, :show, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
