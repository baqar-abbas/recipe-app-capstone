require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Food #index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'baqarnoorali', email: 'baqarnoorali@gmail.com', password: 'baqarnoorali')
    @food1 = Food.create(name: 'first food', measurement_unit: 'kg', price: 300, quantity: 5, user_id: @user.id)
    @food2 = Food.create(name: 'second food', measurement_unit: 'pound', price: 300, quantity: 4, user_id: @user.id)

    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'Log in'
  end

it 'should display a Add Food button on page' do
    visit user_foods_path(@user)
  expect(page).to have_content("Add Food")
end

it 'should display 1st Food/measurement_unit & price of foods' do
    visit user_foods_path(@user)
    expect(page).to have_content(@food1.name)
    expect(page).to have_content(@food1.measurement_unit)
    expect(page).to have_content(@food1.price)
end

it 'should display 2st Food/measurement_unit & price of foods' do
    visit user_foods_path(@user)
    expect(page).to have_content(@food2.name)
    expect(page).to have_content(@food2.measurement_unit)
    expect(page).to have_content(@food2.price)
end

it 'should display a Delete button on the page' do
    visit user_foods_path(@user)
    expect(page).to have_content("Delete")
end

it 'When I click to Add Food button, I should go to food new page.' do
    visit user_foods_path(@user)
    click_on 'Add Food'
    expect(page).to have_current_path(new_user_food_path(@user))
  end  
end