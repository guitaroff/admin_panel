class Api::V1::UsersController < Api::V1::BaseController
  def create
    @user     = User.new(user_params)
    @user.api = true

    if @user.save
      render :create, status: 201
    else
      render json: { data: { errors: @user.errors } }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
