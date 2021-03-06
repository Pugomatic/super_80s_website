Rails.application.routes.draw do
  get '/' => 'high_voltage/pages#show', id: 'video', as: 'root'
  get '/twitter' => 'high_voltage/pages#show', id: 'twitter', as: 'twitter'
  get '/video' => 'high_voltage/pages#show', id: 'video', as: 'video'
  get '/gameplay' => 'high_voltage/pages#show', id: 'gameplay', as: 'gameplay'
  get '/faq' => 'high_voltage/pages#show', id: 'faq', as: 'faq'
  get '/music' => 'high_voltage/pages#show', id: 'music', as: 'music'
  get '/screenshots' => 'high_voltage/pages#show', id: 'screenshots', as: 'screenshots'
  get '/press' => 'high_voltage/pages#show', id: 'press', as: 'press'
  get '/story' => 'high_voltage/pages#show', id: 'story', as: 'story'
  get '/press-kit' => 'high_voltage/pages#show', id: 'press', as: 'press_kit'

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

  get '/choppercommando' => 'chopper_commando#index'

  resources :synthwave, only: [:index]

  get '/blog', to: redirect('/')
  get '/blog/*', to: redirect('/')
end
