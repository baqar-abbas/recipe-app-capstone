require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(
      name: 'User one',
      email: 'user@example.com',
      password: 'password'
    )
    @recipe_one = @user.recipes.create(name: 'Recipe One', description: 'Recipe One Description')
  end

  describe 'validations' do
    it 'is valid with a name and description' do
      expect(@recipe_one).to be_valid
    end

    it 'is invalid without a user_id' do
      @recipe_one.user_id = nil
      expect(@recipe_one).to_not be_valid
    end

    it 'is invalid without a name' do
      @recipe_one.name = nil
      expect(@recipe_one).to_not be_valid
    end

    it "it's default should be private" do
      expect(@recipe_one.public).to be_falsy
    end
  end
end
