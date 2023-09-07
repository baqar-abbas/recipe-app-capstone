class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @foods = @user.foods
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
    respond_to do |format|
      format.html { render :new, locals: { post: @recipe_food, user: @user } }
    end
  end
end
