Rails.application.routes.draw do

  get '/login', to: 'sessions#new', as: "login"
  get '/logout', to: 'sessions#destroy', as: "logout"

  get 'about/index'

  get 'home/index'

  get '/search', to: "home#search", as: 'search'

  get '(/:field)/byletter/:letter', to: 'yairs#by_letter'

  root 'home#index'

  resources :yairs do
    resources :social_media_accounts do
      resources :posts
    end
    resources :posts
  end

  resources :sessions

  match '/contacts', to: 'contacts#new', via: 'get'
	resources "contacts", only: [:new, :create]

  namespace :admin do
    resources :users
    get '/dashboard', to: 'dashboard#index', as: 'dashboard'
    # resource :dashboard
  end

end
