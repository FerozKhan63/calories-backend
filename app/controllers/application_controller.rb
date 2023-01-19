class ApplicationController < ActionController::API
  before_action :set_current_user
  before_action :authenticate_user!

  attr_reader :current_user

  private

  def set_current_user
    @current_user = AuthorizeUser.new(request.headers['auth-token']).call if request.headers['auth-token'].present?
    Current.user = current_user
  end

  def authenticate_user!
    raise Exception.new("Please login to continue.") if current_user.blank?
  end
end
