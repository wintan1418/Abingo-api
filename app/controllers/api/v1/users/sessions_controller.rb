class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_by(email: sessions_params[:email])

    if user&.valid_password?(sessions_params[:password])
      render json: {
        message: 'Logged in successfully.',
        token: generate_jwt_token(user)
      }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render json: { message: "Logged out successfully." }, status: :ok
    else
      render json: { error: "Something went wrong." }, status: :unauthorized
    end
  end

  private

  def sessions_params
    params.require(:user).permit(:email, :password)
  end

  def generate_jwt_token(resource)
    payload = {
      user_id: resource.id,
      exp: 24.hours.from_now.to_i
    }
    JWT.encode(payload, Rails.application.credentials.devise[:jwt_secret_key])
  end
end