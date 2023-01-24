class AuthenticateUser
  attr_accessor :email, :password, :remember_me, :role

  def initialize(params)
    @email = params[:email]
    @password = params[:password]
    @remember_me = params[:remember_me]
    @role = params[:role]
  end

  def call
    return  if user.blank?

    expiration_time = remember_me? && 1.year.from_now || 24.hours.from_now
    JsonWebToken.encode({ user_id: user.id }, expiration_time)
  end

  def user
    @user ||= User.authenticate(email, password)
  end

  def remember_me?
    remember_me.in? [true, 'true']
  end
end
