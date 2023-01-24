class Api::V1::MealsController < ApplicationController
  before_action :set_meal, only: [:show, :update, :destroy]
  
  def index
    @meals = current_user.meals

    render json: @meals
  end

  def show
    render json: @meals
  end  

  def create
    @meal = current_user.meals.new(meal_params)

    if @meal.save
      render json: { message: 'Meal added successfully' }
    else
      render json: { message: @meal.errors.to_a }, status: :forbidden
    end
  end

  def update
    if @meal.update(meal_params)
      render json: { message: 'Meal updated successfully' }
    else
       render json: { message: @meal.errors.to_a }, status: :forbidden
    end
  end

  def destroy
    if @meal.destroy!
      render json: {message: 'Meal deleted'}
    else
       render json: { message: @meal.errors.to_a }, status: :forbidden
    end
  end

  private

  def meal_params
    params.permit(:name, :description, :calorie_intake, :start_date, :end_date) 
  end

  def set_meal
    @meal = current_user.meals.find(params[:id])
  end
end