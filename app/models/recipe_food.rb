class RecipeFood < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :food_id, uniqueness: { scope: :recipe_id }
end
