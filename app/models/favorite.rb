class Favorite < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :recipe_id, presence: true

  def self.get_recipe_ids(user)
    Favorite.where(user: user).pluck(:recipe_id).join(',')
  end
end
