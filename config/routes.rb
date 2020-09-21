Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  get "power", to: "pages#power"
  scope '/power' do
    resources :seasons, only: [:index], as: "power_seasons"
  end

end
