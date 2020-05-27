class Restriction < ApplicationRecord
  has_many :user_restrictions
  has_many :users, through: :user_restrictions

  validates :type, presence: true
end