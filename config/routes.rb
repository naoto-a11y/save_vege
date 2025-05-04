Rails.application.routes.draw do
  devise_for :customers,skip: [:passeord], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :farmers,skip: [:passwords], controllers: {
    registrations: "farmer/registrations",
    sessions: 'farmer/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: 'homes#top'
  get 'homes/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
