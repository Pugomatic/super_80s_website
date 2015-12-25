Rails.application.routes.draw do
  get '/' => 'high_voltage/pages#show', id: 'video'
  get '/twitter' => 'high_voltage/pages#show', id: 'twitter'
  get '/video' => 'high_voltage/pages#show', id: 'video'
  get '/screenshots' => 'high_voltage/pages#show', id: 'screenshots'
  get '/press' => 'high_voltage/pages#show', id: 'press'
  get '/press-kit' => 'high_voltage/pages#show', id: 'press'
  get '/admin/email' => 'admin/email#index'

  comfy_route :blog_admin, :path => '/admin'
  comfy_route :blog, :path => '/blog'

  comfy_route :cms_admin, :path => '/admin'

  # Make sure this routeset is defined last
  comfy_route :cms, :path => '/', :sitemap => false

  resources :users, only: [:create]
end
