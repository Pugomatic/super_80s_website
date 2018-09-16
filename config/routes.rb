Rails.application.routes.draw do
  devise_for :players, controllers: {
      sessions: 'sessions',
      registrations: 'registrations',
      omniauth_callbacks: "players/omniauth_callbacks"
  }

  get '/' => 'high_voltage/pages#show', id: 'video', as: 'root'
  get '/twitter' => 'high_voltage/pages#show', id: 'twitter', as: 'twitter'
  get '/video' => 'high_voltage/pages#show', id: 'video', as: 'video'
  get '/gameplay' => 'high_voltage/pages#show', id: 'gameplay', as: 'gameplay'
  get '/music' => 'high_voltage/pages#show', id: 'music', as: 'music'
  get '/screenshots' => 'high_voltage/pages#show', id: 'screenshots', as: 'screenshots'
  get '/press' => 'high_voltage/pages#show', id: 'press', as: 'press'
  get '/story' => 'high_voltage/pages#show', id: 'story', as: 'story'
  get '/press-kit' => 'high_voltage/pages#show', id: 'press', as: 'press_kit'
  get '/admin/email' => 'admin/email#index'
  get '/press/demo' => 'demo#index'
  get '/press/demo/unity3d' => 'demo#unity3d'

  get '/shop' => 'high_voltage/pages#show', id: 'tshirt'
  get '/tshirt' => 'high_voltage/pages#show', id: 'tshirt'
  get '/t-shirt' => 'high_voltage/pages#show', id: 'tshirt'
  get '/dan' => 'high_voltage/pages#show', id: 'dan'
  get '/dan/camaro' => 'high_voltage/pages#show', id: 'dan'
  get '/dancamaro' => 'high_voltage/pages#show', id: 'dan'
  get '/dan_camaro' => 'high_voltage/pages#show', id: 'dan'
  get '/DanCamaro' => 'high_voltage/pages#show', id: 'dan'
  get '/Dan' => 'high_voltage/pages#show', id: 'dan'
  get '/privacy' => 'high_voltage/pages#show', id: 'privacy'

  get '/noid' => 'high_voltage/pages#show', id: 'noid'
  get '/noid/wormser' => 'high_voltage/pages#show', id: 'noid'
  get '/dr/noid/wormser' => 'high_voltage/pages#show', id: 'noid'

  get '/delorean' => 'high_voltage/pages#show', id: 'delorean'
  get '/delorean/dmc12' => 'high_voltage/pages#show', id: 'delorean'

  namespace :game do
    resources :leaderboards
    resources :discographies
    resources :profiles
    resources :players
    resources :sign_ins
  end

  resources :synthwave, only: [:index]

  resources :beta_testers, only: [:index]

  comfy_route :cms_admin, :path => '/admin'
  comfy_route :blog_admin, :path => '/admin'
  comfy_route :blog, :path => '/blog'

  resources :users, only: [:create]
end
