class JsonWebToken
  # NOTE: added default secret key just for simplicity, since this is a test-task;
  # one should NEVER have default secret for auth token in production =)
  SECRET_KEY = ENV['SERVER_SECRET'] || 'very_secret'
  DEFAULT_EXPIRE_TIME = 24.hours.from_now

  class << self
    def encode(body, expire = DEFAULT_EXPIRE_TIME)
      # JWT requires
      body[:exp] = expire.to_i

      JWT.encode(body, SECRET_KEY)
    end

    def decode(token)
      # JWT#decode returns array: [{"user_id"=>1, "expire"=>1625589659}, {"alg"=>"HS256"}]
      decoded = JWT.decode(token, SECRET_KEY)[0]

      HashWithIndifferentAccess.new decoded
    end
  end
end
