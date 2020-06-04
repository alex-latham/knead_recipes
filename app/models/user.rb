class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :user_restrictions, dependent: :destroy
  has_many :restrictions, through: :user_restrictions
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :name, presence: true
  validates :email, presence: true
  validates :username, uniqueness: true
  validates :image, presence: true

  def add_friend(username)
    new_friend = User.find_by(username: username)
    return false if new_friend.nil? || friends.include?(new_friend)

    Friendship.create!(user_id: id, friend_id: new_friend.id)
    Friendship.create!(user_id: new_friend.id, friend_id: id)
    true
  end

  def share_recipe_with_friends(recipe_mailer_params)
    friends.each do |friend|
      email_info = {
        user: username,
        friend: friend.username,
        friend_email: friend.email,
        recipe_title: recipe_mailer_params[:title],
        recipe_id: recipe_mailer_params[:id]
      }
      RecipeMailerJob.perform_later(email_info)
    end
  end

  def restriction_list
    restrictions.map(&:name)
  end

  def favorited?(recipe_id)
    favorites.pluck(:recipe_id).include?(recipe_id)
  end

  def self.from_omniauth(response)
    find_or_create_by(email: response['info']['email']) do |user|
      user.name ||= response['info']['name']
      user.username ||= response['info']['email'].split('@').first
      user.image ||= response['info']['image']
    end
  end
end
