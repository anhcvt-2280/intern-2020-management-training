Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    namespace :trainers do
      root "subjects#index"
      resources :courses
      resources :topics, only: :index
      resources :search_trainees, only: :index
      resources :subjects, except: %i(edit update)
      resources :users
    end
    
    namespace :trainee do
      root "courses#index"
      resources :courses
    end
  end
end
