class Api::V1::UsersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: :create

  def index
    render json: User.all, status: 200
  end

  def show
    user = User.find(params[:id])
    render json: user, status: 200
  end

  def create
    user     = User.new(user_params)
    user.api = true

    if user.save
      render json: user.as_json(only: [:id, :email, :authentication_token]), status: 201
    else
      render json: { data: { errors: user.errors } }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
