class ApplicationController < ActionController::API

  before_action :authenticate_user!
  before_action :set_current_user

  attr_reader :current_user

  private

  def set_current_user
    @current_user = AuthorizeUser.new(request.headers['auth-token']).call if request.headers['auth-token'].present?
    Current.user = current_user
  end

  def authenticate_user!
    raise ExceptionHandler::MissingToken, Message.missing_token if current_user.blank?
  end
end
