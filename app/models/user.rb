class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :user_restrictions, dependent: :destroy
  has_many :restrictions, through: :user_restrictions
  has_many :friendships, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  def self.from_omniauth(response)
    where(email: response.info.email).first_or_initialize do |user|
      user.name = response.info.name
      user.email = response.info.email
    end
  end
end
