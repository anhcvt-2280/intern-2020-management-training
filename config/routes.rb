require "sidekiq/web"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  scope "(:locale)", locale: /en|vi/ do
    root "homes#index"

    namespace :trainers do
      root "subjects#index"
      resources :courses do
        resources "user_courses", only: :show do
          resources :comments, only: %i(create destroy)
        end
        resources "subject_courses", only: :show
      end
      resources :topics, only: :index
      resources :search_trainees, only: :index
      resources :subjects
      resources :users
      resources "import_users", only: :create
      resources :comments, only: :destroy do
        resources :comments, only: %i(create destroy)
      end
    end

    namespace :trainee do
      root "courses#index"
      resources :reports
      resources :courses do
        resources :subjects
      end
      resources :user_tasks, only: :update
      resources :user_course_subjects, only: :update
    end

    devise_for :users,
               controllers: {
                 sessions: :sessions,
                 registrations: :registrations,
                 passwords: "users/passwords"
               },
               path_names: {sign_in: :login, sign_out: :logout, edit: :edit_password}
  end
  match '*unmatched', to: 'application#rescue_404_exception', via: :all
  match '*a', :to => 'application#not_found', via: :all
end
