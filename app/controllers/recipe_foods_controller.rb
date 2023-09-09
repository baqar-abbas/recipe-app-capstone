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

  def edit
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe
  end

  def update
    @user = User.find(params[:user_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.quantity = params[:recipe_food][:quantity]

    if @recipe_food.save
      redirect_to user_recipe_path(@user, @recipe_food.recipe), notice: 'Recipe Food was updated successfully'
    else
      flash.now[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
      render :edit, status: 400
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe

    if @recipe_food.destroy
      redirect_to user_recipe_path(@user, @recipe), notice: 'Recipe Food was deleted successfully'
    else
      flash.now[:alert] = @recipe_food.errors.full_messages.first if @recipe_food.errors.any?
      render :new, status: 400
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
