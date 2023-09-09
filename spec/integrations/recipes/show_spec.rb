require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Recipe #show page', type: :feature do
  before(:each) do
    @user = User.create(name: 'baqarnoorali', email: 'baqarnoorali@gmail.com', password: 'baqarnoorali')
    @food = Food.create(name: 'first food', measurement_unit: 'kg', price: 300, quantity: 5, user_id: @user.id)
    @recipe = Recipe.create(name: 'first recipe', description: 'this is my first recipe',
        preparation_time: '25', cooking_time: '13', user: @user)

    @recipe_food1 = RecipeFood.create(quantity: 6, recipe_id: @recipe.id, food_id: @food.id)
    @recipe_food2 = RecipeFood.create(quantity: 2, recipe_id: @recipe.id, food_id: @food.id)

    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
  end

  it 'should display a recipe name' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content(@recipe.name)
  end

  it 'should display a recipe description' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content(@recipe.description)
  end

  it 'should display recipe preparation time' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content(@recipe.preparation_time)
  end

  it 'should display recipe cooking time' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content(@recipe.cooking_time)
  end

  it 'should display a Generate shopping list button' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content('Generate Shopping List')
  end

  it 'should display a Add ingredients button' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content('Add Ingredient')
  end

  it 'should display all the elements in ingredients table' do
    visit user_recipe_path(@user, @recipe)
    @recipe.recipe_foods.each do |recipe_food_items|
      expect(page).to have_content(recipe_food_items.food.name)
      expect(page).to have_content(recipe_food_items.food.quantity)
    end
  end

  it 'should display a Remove button on the page' do
    visit user_recipe_path(@user, @recipe)
    expect(page).to have_content('Remove')
  end
end