class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  before_action :authenticate_user!

  protected

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    user_email = options.blank?? nil : options[:email]
    user = user_email && User.find_by(email: user_email)

    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in user, store: false
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
