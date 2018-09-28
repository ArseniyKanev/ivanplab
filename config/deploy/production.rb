set :stage, :production
server '176.112.215.234', user: 'deploy', roles: %w{web app db}
