require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Food #index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'baqarnoorali', email: 'baqarnoorali@gmail.com', password: 'baqarnoorali')
    @recipe1 = Recipe.create(name: 'first recipe', description: 'this is my first recipe',
                             preparation_time: '25', cooking_time: '13', user: @user)
    @recipe2 = Recipe.create(name: 'second recipe', description: 'this is my second recipe', preparation_time: '10',
                             cooking_time: '10', user: User.first)

    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
  end

  it 'should display a New Recipe button on page' do
    visit user_recipes_path(@user)
    expect(page).to have_content('New Recipe')
  end

  it 'should display 1st Food & description of recipes' do
    visit user_recipes_path(@user)
    expect(page).to have_content(@recipe1.name)
    expect(page).to have_content(@recipe1.description)
  end

  it 'should display 2st Food & description of recipes' do
    visit user_recipes_path(@user)
    expect(page).to have_content(@recipe2.name)
    expect(page).to have_content(@recipe2.description)
  end

  it 'should display a Delete button on the page' do
    visit user_recipes_path(@user)
    expect(page).to have_content('Delete')
  end

  it 'When I click on New Recipe button the I should go to new recipe page' do
    visit user_recipes_path(@user)
    click_on 'New Recipe'
    expect(page).to have_current_path(new_user_recipe_path(@user))
  end
end
