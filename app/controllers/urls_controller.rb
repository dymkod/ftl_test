class UrlsController < ApplicationController
  before_action :authorize_response

  def show
    code = params[:code]
    url = Url.find_by(code: code)

    if url
      render json: { url: url }
    else
      head :internal_server_error
    end
  end

  def create
    url = url_params[:url]
    code = CodeGenerateService.new(url).generate

    if Url.create(url, code)
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
