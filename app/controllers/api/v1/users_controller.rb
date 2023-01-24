class Api::V1::UsersController < ApplicationController
  before_action :set_user

  def show_profile
    render json: current_user
  end

  def update
    if @user.update(user_params)
      render json: 'Profile updated successfully'
    else
      render json: { error: @user.errors.to_a }, status: :forbidden
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.permit(:first_name, :last_name, :calorie_limit)
  end
end