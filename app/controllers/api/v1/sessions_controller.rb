class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def signup
    @user = User.new(signup_params)

    if @user.save
      render json: user_success_response
    else
      render json: { message: 'Error creating user.' }
    end
  end

  def create
    @user = User.find(JsonWebToken.decode(auth_token)[:user_id])

    render json: user_success_response
  end

  private

  def auth_token
    AuthenticateUser.new(authentication_params).call
  end

  def signup_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def authentication_params
    params.permit(:email, :password, :remember_me)
  end

  def user_success_response
    { auth_token: auth_token, first_name: @user.first_name, last_name: @user.last_name, email: @user.email, user_id: @user.id }
  end
end
