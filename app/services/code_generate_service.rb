class CodeGenerateService
  def initialize(url)
    @url = url
  end

  def generate
    # url, base64, SHA, 8 last chars
    url_with_salt = @url.concat(Time.now.to_s)
    base = Base64.encode64(url_with_salt)

    Digest::SHA1.new.update(base).hexdigest.last(Url::CODE_LENGHT)
  end
end
