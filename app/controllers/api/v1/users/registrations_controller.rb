class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    if resource.persisted?
      render json: resource, status: :created
    else
      render json: { message: "Something went wrong.", errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
   def new
    @user = User.new
  end


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: { message: 'Signed up successfully.' }
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end
end
