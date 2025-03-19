Rails.application.routes.draw do
  # get "blog/index"
  # get "blog/show"
  devise_for :users
  get "beta_signups/create"
  get "pages/home"
  get "job_posts/index"
  get "job_posts/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"
  resources :job_posts, only: [ :index, :show ]
  resources :beta_signups, only: [ :create ]

  # Blog Routes
  resources :blog, only: [ :index, :show ]

  # Blog Admin routes
  namespace :admin do
    resources :blog_posts
  end
end
