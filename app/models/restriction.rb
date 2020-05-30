class Restriction < ApplicationRecord
  has_many :user_restrictions, dependent: :destroy
  has_many :users, through: :user_restrictions

  validates :name, presence: true
end
