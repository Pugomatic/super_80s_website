Rails.application.routes.draw do
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

  get '/debbie' => 'high_voltage/pages#show', id: 'debbie'
  get '/debbie/whatever' => 'high_voltage/pages#show', id: 'debbie'
  get '/debbie/what-ever' => 'high_voltage/pages#show', id: 'debbie'

  get '/noid' => 'high_voltage/pages#show', id: 'noid'
  get '/noid/wormser' => 'high_voltage/pages#show', id: 'noid'
  get '/dr/noid/wormser' => 'high_voltage/pages#show', id: 'noid'

  get '/delorean' => 'high_voltage/pages#show', id: 'delorean'
  get '/delorean/dmc12' => 'high_voltage/pages#show', id: 'delorean'

  namespace :game do
    resources :leaderboards
  end

  resources :synthwave, only: [:index]

  resources :players, only: [:index, :create] do
    collection do
      get :award
    end
  end

  resources :beta_testers, only: [:index]

  comfy_route :blog_admin, :path => '/admin'
  comfy_route :blog, :path => '/blog'

  comfy_route :cms_admin, :path => '/admin'

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', sitemap: true

  resources :users, only: [:create]
end
