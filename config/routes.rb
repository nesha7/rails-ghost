Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  authenticate :user, ->(u) { u.admin? } do
    get  'admin/scripts',       to: 'scripts#index',  as: :scripts
    patch 'admin/scripts/update', to: 'scripts#update', as: :update_script
  end

  # Defines the root path route ("/")
  root "pages#index"

  get '/phrasing', to: 'phrasing#index'
  get '/phrasing/:id/edit', to: 'phrasing#edit'
  get '/phrasing/help', to: 'phrasing#help'
  get '/phrasing/import_export', to: 'phrasing#import_export'
  get '/phrasing/download', to: 'phrasing#download'
  patch '/phrasing/:id', to: 'phrasing#update'
  delete '/phrasing/:id/destroy', to: 'phrasing#destroy'
  
  get '/blog', to: 'blogs#index'
  get '/blog/:slug', to: 'blogs#show'
  get '/sitemap.xml.gz', to: 'sitemaps#show', format: :xml
  get '/robots.txt', to: 'robots#show'

  match '*path', to: 'pages#show', via: :get
end
