class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  enum status: %i[pending accepted declined blocked]

  validates :status, presence: true

  before_create :user_cannot_be_own_friend

  def user_cannot_be_own_friend
    raise 'You cannot send yourself a friend request' if user_id == friend_id

    true
  end

  # validates :friend, uniqueness: { scope: :user, message: 'You cannot add yourself as a friend' }
end
