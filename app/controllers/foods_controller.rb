class FoodsController < ApplicationController
  load_and_authorize_resource

  def index
    @foods = Food.where(user_id: current_user.id).includes(:user)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      redirect_to user_foods_path, notice: 'Food created successfully.'
    else
      render :new, alert: 'Failed to create Food!'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to user_foods_path, notice: 'Food deleted successfully.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
