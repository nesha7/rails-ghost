Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"

  get '/blog', to: 'pages#blogs'

  get '/phrasing', to: 'phrasing#index'
  get '/phrasing/:id/edit', to: 'phrasing#edit'
  get '/phrasing/help', to: 'phrasing#help'
  get '/phrasing/import_export', to: 'phrasing#import_export'
  get '/phrasing/download', to: 'phrasing#download'
  patch '/phrasing/:id/update', to: 'phrasing#update'
  delete '/phrasing/:id/destroy', to: 'phrasing#destroy'

  constraints host: %w[ruby.ci fast.ci] do
    get '/about_us', to: 'pages#about_us'
    get '/pricing', to: 'pages#pricing'
    get '/circle_ci', to: 'pages#circle_ci'
    get '/github_ci', to: 'pages#github_ci'
    get '/jenkins_ci', to: 'pages#jenkins_ci'
    get '/get_started', to: 'pages#get_started'
    get '/features', to: 'pages#features'
  end

  constraints host: %w[kolosek.com] do
    get '/about', to: 'pages#about'
    get '/contact', to: 'pages#contact'
    get '/process', to: 'pages#process_page'
    get '/code_review', to: 'pages#code_review'
    get '/portfolio', to: 'pages#portfolio'
    get '/featured', to: 'pages#featured'
  end

  constraints host: %w[demo.litetracker.com litetracker.com] do
    get '/pricing', to: 'pages#pricing'
    get '/about', to: 'pages#about'
    get '/integrations', to: 'pages#integrations'
    get '/onboard', to: 'pages#onboard'
  end

  get '/blog/:slug', to: redirect { |path_params, req| "/#{path_params[:slug]}" }

  match '*path', to: 'pages#post', via: :get
end
