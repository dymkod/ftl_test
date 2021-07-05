class ApplicationController < ActionController::API
  def current_user
    @current_user ||= authorized_request_user
  end

  def authenticate_user!
    unless current_user.present?
      render(json: { error: 'unauthorized' }, status: :unauthorized) and return
    end

    true
  end

  private

  def authorized_request_user
    # might be better to move specific logic to some service, not sure
    header = request.headers['Authorization']
    return false if header.blank?
    header = header.split(' ').last

    begin
      decoded = JsonWebToken.decode(header)

      # using find_by to get soft response in case of failure
      User.find_by(id: decoded[:user_id])
    rescue JWT::DecodeError => e
      # in this case we will return 'unauthorized' error in method above
      false
    end
  end
end
