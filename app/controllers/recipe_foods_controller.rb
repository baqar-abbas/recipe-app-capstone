class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @foods = @user.foods
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build
  end

  def create
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)

    if @recipe_food.save
      redirect_to user_recipe_path(@user, @recipe), notice: 'Food item added successfully'
    else
      render :new
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
