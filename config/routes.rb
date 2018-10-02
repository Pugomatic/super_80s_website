Rails.application.routes.draw do
  comfy_route :blog_admin, path: "/admin"
  comfy_route :blog, path: "/blog"
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

  get '/game/beta_competition' => 'game/leaderboards#index', start: 'beta_competition'

  namespace :game do
    resources :leaderboards
    resources :profiles do
      resources :discographies
    end
    resources :players
    resources :favorites
    resources :sign_ins
    resources :data
  end

  resources :synthwave, only: [:index]

  resources :beta_testers, only: [:index]

  comfy_route :cms_admin, path: '/admin'

  resources :users, only: [:create]

  get '/blog/synthwave-questionnaire---part-1',
      to: redirect('/blog/2017/10/synthwave-questionnaire---part-1')
  get '/blog/synthwave-questionnaire---part-2',
      to: redirect('/blog/2017/10/synthwave-questionnaire---part-2')
  get '/blog/synthwave-questionnaire---part-3',
      to: redirect('/blog/2017/10/synthwave-questionnaire---part-3')
  get '/blog/collaborate-with-others-on-your-video-game',
      to: redirect('/blog/2015/12/collaborate-with-others-on-your-video-game')
  get '/blog/finish-your-game-with-this-one-simple-lesson',
      to: redirect('/blog/2018/6/finish-your-game-with-this-one-simple-lesson')
  get '/blog/super-80s-world-halloween-trailer',
      to: redirect('/blog/2017/10/super-80s-world-halloween-trailer')
  get '/blog/super-80s-world-at-the-smithsonian-arcade',
      to: redirect('/blog/2017/8/super-80s-world-at-the-smithsonian-arcade')
  get '/blog/development-log-entry-1-early-gameplay-feedback',
      to: redirect('/blog/2016/3/development-log-entry-1-early-gameplay-feedback')
  get '/blog/dont-hate-the-hater-learn-about-your-game',
      to: redirect('/blog/2016/1/dont-hate-the-hater-learn-about-your-game')
  get '/blog/use-pickfu-to-a-b-testing-your-game-ideas',
      to: redirect('/blog/2016/1/use-pickfu-to-a-b-testing-your-game-ideas')
  get '/blog/make-your-own-retro-vgs',
      to: redirect('/blog/2015/12/make-your-own-retro-vgs')
  get '/blog/talk-to-your-local-sba',
      to: redirect('/blog/2015/12/talk-to-your-local-sba')
end
