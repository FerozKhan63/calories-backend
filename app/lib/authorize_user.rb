class AuthorizeUser
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def call
    user
  end

  def consumer
    @user ||= User.find(JsonWebToken.decode(token)[:user_id])
  end
end
