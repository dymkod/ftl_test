class AuthController < ApplicationController
  def login
    user = User.find_by(email: login_params[:email])
    if user.nil?
      render json: { error: 'not_found'}, status: :not_found
      return
    end

    if user.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      pretty_time = JsonWebToken::EXPIRE_TIME.strftime("%m-%d-%Y %H:%M")
      render json: { token: token, exp: pretty_time,
                     username: user.username }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
