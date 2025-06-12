Rails.application.routes.draw do
 
  devise_for :customers,skip: [:password], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  root to: 'homes#top'
  get 'about', to: "homes#about"


  scope module: :public do
    
    resources :items, only: [:index, :show] do
      resources :comments,   only: [:create, :destroy]
      resources :reservations, only: [:create]
    end
    
    resources :reservations, only: [:index, :destroy]

    patch 'reservations/:id/complete', to: "reservations#complete", as: :complete_reservation
    patch 'reservations/:id/cancel',   to: "reservations#cancel",   as: :cancel_reservation
    get 'reservations/history',        to: 'reservations#history',  as: :reservation_history

    get    'customers/my_page',          to: "customers#show"
    get    'customers/information/edit', to: "customers#edit"
    patch  'customers/information',      to: "customers#update"
    get    'customers/unsubscribe',      to: "customers#unsubscribe"
    patch  'customers/withdraw',         to: "customers#withdraw"
    


    resources :farmers, path: "customer_farmers", only: [:show] do
      resource :follow,    only: [:create, :destroy, :show]
    end

    resources :follows,    only: [:index]
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
    patch 'items/:id/deactivate', to: "items#deactivate", as: 'deactivate_farmer_item'
    patch 'items/:id/activate', to: "items#activate", as: 'activate_farmer_item'
    resources :reservations, only: [:index, :destroy]

    patch 'reservations/:id/complete', to: "reservations#complete", as: :complete_reservation
    patch 'reservations/:id/cancel',   to: "reservations#cancel",   as: :cancel_reservation
    get 'reservations/history',        to: 'reservations#history',  as: :reservation_history

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
    get 'top', to: "homes#top"
    resources :categories,   only: [:index, :update, :destroy, :create]
    resources :tags,         only: [:index, :destroy]
    resources :customers,    only: [:index, :update, :edit, :show]
    resources :farmers,      only: [:index, :show, :update, :edit] do
      resources :items,      only: [:index, :destroy, :update, :show, :edit], module: :farmers do
        resources :comments,   only: [:destroy]
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
