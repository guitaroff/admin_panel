class Api::V1::SessionsController < Api::V1::BaseController
  def create
    user = User.where(email: params[:email]).first

    if user&.valid_password?(params[:password])
      render json: user.as_json(only: [:email, :authentication_token]), status: 201
    else
      head(:unauthorized)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
