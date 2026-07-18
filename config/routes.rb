Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: 'pages#top'
  get 'pages/top'
  get "users/profile", to: "users#show", as: :user_profile

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "home", to: "home#index", as: :home
  get "incomes/edit_all", to: "incomes#edit_all", as: :edit_all_incomes
  resources :incomes

  get "future_expenses/edit_all", to: "future_expenses#edit_all", as: :edit_all_future_expenses
  resources :future_expenses

  get "fixed_costs/edit_all", to: "fixed_costs#edit_all", as: :edit_all_fixed_costs
  resources :fixed_costs

  resources :transactions, only: [ :index, :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  patch "home/update_job_search", to: "users#update_job_search", as: :update_job_search
  # Defines the root path route ("/")
  # root "posts#index"
end
