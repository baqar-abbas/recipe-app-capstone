class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, uniqueness: { scope: :user_id }
end
