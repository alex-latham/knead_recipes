class User < ApplicationRecord
  has_many :favorites
  has_many :user_restrictions
  has_many :restrictions, through: :user_restrictions
  has_many :friendships

  validates :name, presence: true
  validates :email, presence: true
end