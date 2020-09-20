require "sidekiq/web"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    namespace :trainers do
      root "subjects#index"
      resources :courses do
        resources "user_courses", only: :show
        resources "subject_courses", only: :show
      end
      resources :topics, only: :index
      resources :search_trainees, only: :index
      resources :subjects
      resources :users
      resources "import_users", only: :create
    end

    namespace :trainee do
      root "courses#index"
      resources :reports
      resources :courses do
        resources :subjects
      end
      resources :user_tasks, only: :update
    end
  end
end
