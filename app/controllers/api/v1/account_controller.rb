class Api::V1::AccountController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  def show
    render json: current_user.as_json(except: [:api, :authentication_token]), status: 200
  end

  def update
    user     = current_user
    user.api = true

    if user.valid?
      user.update(account_params.merge({api: true}))
      render json: user.as_json(except: [:api, :authentication_token]), status: 200
    else
      render json: { data: { errors: user.errors } }, status: 422
    end
  end

  def avatar_upload
    if current_user.update(avatar: params[:avatar], api: true)
      render json: current_user.as_json(except: [:api, :authentication_token]), status: 200
    else
      render json: { data: { errors: current_user.errors } }, status: 422
    end
  end

  private

  def account_params
    params.require(:user).permit(:name)
  end
end
