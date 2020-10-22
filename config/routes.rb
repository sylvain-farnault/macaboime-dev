Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get "power", to: "pages#power"
  scope '/power' do
    resources :seasons, only: [:index, :create, :show, :destroy]
    resources :competitions, only: [:index, :create, :show, :destroy]
    resources :teams, only: [:index, :create, :show]
    resources :editions, only: [:index, :create]
    resources :editions, only: [:show] do
      resources :contestants, only: [:index, :create]
      resources :schedules, only: [:index, :create] do
        post "results", to: "results#update_results"
      end
      post "games", to: "schedules#generate_games"
    end
    get "results", to: "results#enter_results", as: "enter_results"
  end

end
