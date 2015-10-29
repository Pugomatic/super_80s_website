set :stage, :production
server '159.203.118.206', roles: %w(web app db assets), user: 'deploy'
