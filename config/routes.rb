Rails.application.routes.draw do
  devise_for :teachers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :classrooms do
    member do
      patch :update_current_seating_chart
    end
  end
  resources :seating_charts
  resources :students
  
  # Defines the root path route ("/")
  root "classrooms#index"
end