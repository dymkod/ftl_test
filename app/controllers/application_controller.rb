class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def current_user
    @current_user ||= authorized_request_user
  end

  private

  def authenticate_user!
    unless current_user.present?
      render_unauthorized_error and return
    end

    true
  end

  def authorized_request_user
    # TODO: move most of logic to some service
    header = request.headers['Authorization']
    if header.blank?
      render_unauthorized_error and return
    end

    header = header.split(' ').last

    begin
      decoded = JsonWebToken.decode(header)
      User.find_by(id: decoded[:user_id]) # using find_by to get soft response in case of failure
    rescue JWT::DecodeError => e
      render_unauthorized_error(e.message)
    end
  end

  def render_unauthorized_error(error = 'unauthorized')
    render json: { error: error }, status: :unauthorized
  end

end
