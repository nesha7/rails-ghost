Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"

  get '/blog', to: 'pages#blogs'
  get '/about_us', to: 'pages#about_us'
  get '/pricing', to: 'pages#pricing'
  get '/circle_ci', to: 'pages#circle_ci'
  get '/github_ci', to: 'pages#github_ci'
  get '/jenkins_ci', to: 'pages#jenkins_ci'
  get '/get_started', to: 'pages#get_started'

  match '*path', to: 'pages#post', via: :get
end
