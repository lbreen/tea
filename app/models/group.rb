class Group < ApplicationRecord
	has_many :user_groups, dependent: :destroy
	has_many :users, through: :user_groups

	validates :name, length: { maximum: 26 }

  def is_a_user?(user)
    self.users.each { |group_user| return true if group_user == user }
    false
  end
end
