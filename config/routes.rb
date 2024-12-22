Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get "saisons/:season_years", to: "pages#season_show", as: "season_show"
  resources :schedules, only: [:show]

  get "power", to: "pages#power"
  scope '/power' do
    resources :seasons, only: [:index, :create, :show, :destroy] do
      member do
        get :stats_stabis
      end
    end
    resources :competitions, only: [:index, :create, :show, :destroy]
    resources :teams, only: [:index, :create, :show]
    resources :stadiums, only: [:new, :create, :index, :edit, :update]
    resources :editions, only: [:index, :create]
    resources :editions, only: [:show] do
      resources :contestants, only: [:index, :create]
      resources :schedules, only: [:index, :create] do
        post "results", to: "results#update_results"
      end
      post "games", to: "schedules#generate_games"
    end
    get "results(/:id)", to: "results#enter_results", as: "enter_results"
    resources :articles
    resources :user_roles, only: [:index, :create, :destroy]
  end

  # Path related to registering preferences in client browser cookies
  post 'update_preferences', to: 'preferences#update'
  post 'cookies_refusal_preferences', to: 'preferences#cookies_refusal'
end
