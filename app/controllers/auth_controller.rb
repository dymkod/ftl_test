class AuthController < ApplicationController
  def login
    # checking only email here, to get jwt token; can be more strict by adding password for user
    user = User.find_by(email: login_params[:email])
    if user.nil?
      render json: { error: 'not_found'}, status: :not_found
      return
    end

    token = JsonWebToken.encode(user_id: user.id)
    pretty_time = JsonWebToken::DEFAULT_EXPIRE_TIME.strftime("%m-%d-%Y %H:%M")
    render json: { token: token, exp: pretty_time }, status: :ok
  end

  private

  def login_params
    params.permit(:email)
  end
end
