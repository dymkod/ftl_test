class UrlsController < ApplicationController
  # since its an API service, assuming we need to authorize all request from client, not just :create
  before_action :authenticate_user!, only: :create

  def show
    code = params[:code]
    url = Url.find_by(code: code)

    if url
      render json: { url: url[:url] }
      #redirect_to url[:url]
    else
      head :internal_server_error
    end
  end

  def create
    url = url_params[:url]
    code = CodeGenerateService.new(url).generate

    if Url.create(url: url, code: code)
      render json: { code: code, status: 200 }
    else
      head :internal_server_error
    end
  end

  private

  def url_params
    params.permit(:url)
  end
end
