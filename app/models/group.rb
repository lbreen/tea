class Group < ApplicationRecord
	has_many :user_groups, dependent: :destroy
	has_many :users, through: :user_groups

  colours = ['rgb(255, 45, 45)', 'rgb(97, 216, 249)', 'rgb(72, 48, 255)', 'rgb(0, 165, 35)', 'rgb(216, 76, 255)', 'rgb(255, 255, 255)']

	validates :name, length: { maximum: 26 }
  validates :colour, inclusion: { in: colours }

  def members
    self.users
  end

  def is_a_member?(user)
    self.users.each { |group_user| return true if group_user == user }
    false
  end
end
