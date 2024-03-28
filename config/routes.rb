Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"

  get '/about_us', to: 'pages#about_us'
  get '/pricing', to: 'pages#pricing'
  get '/vs_circleci', to: 'pages#vs_circle_ci'
  get '/vs_githubci', to: 'pages#vs_github_ci'
  get '/vs_jenkins', to: 'pages#vs_jenkins'
end
