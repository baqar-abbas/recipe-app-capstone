class RecipesController < ApplicationController
  load_and_authorize_resource

  def index
    @recipes = Recipe.where(user_id: current_user.id).includes(:recipe_foods)
  end

  def show
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)

    @is_owner = current_user == @user
    @is_public = @recipe.public?
    @food_item = RecipeFood.new if @is_owner
  end

  def new
    @user = User.find(params[:user_id])
    @recipe = Recipe.new
    @recipe.user = current_user
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to user_recipes_path(id: @recipe.id), notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:user_id])
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to user_recipe_path(@user, @recipe), notice: 'Recipe was successfully updated.'
    else
      render :show
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.find(params[:id])

    if @recipe.destroy
      redirect_to user_recipes_path(user_id: @user.id), notice: 'Recipe was deleted successfully'
    else
      flash.now[:alert] = @recipe.errors.full_messages.first if @recipe.errors.any?
      render :index, status: 400
    end
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
