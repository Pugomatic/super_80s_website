Rails.application.routes.draw do
  get '/' => 'high_voltage/pages#show', id: 'index'
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
