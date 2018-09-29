class SessionsController < Devise::SessionsController
  layout 'admin'
  skip_before_action :verify_authenticity_token, only: :destroy
end
