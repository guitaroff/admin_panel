class Api::V1::AccountController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def show
    render json: current_user.as_json(except: [:api, :authentication_token]), status: 200
  end

  def update
    @user     = current_user
    @user.api = true

    if @user.valid?
      @user.update(user_params)
      render json: @user.as_json(except: [:api, :authentication_token]), status: 200
    else
      render json: { data: { errors: @user.errors } }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
