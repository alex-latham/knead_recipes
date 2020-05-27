class UserRestriction < ApplicationRecord
  belongs_to :user
  belongs_to :restriction

  validates :user_id, presence: true
  validates :restriction_id, presence: true
end
