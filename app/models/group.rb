class Group < ApplicationRecord
	has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members
  belongs_to :admin, class_name: "User", foreign_key: "user_id"

  colours = ['rgb(255, 45, 45)', 'rgb(97, 216, 249)', 'rgb(72, 48, 255)', 'rgb(0, 165, 35)', 'rgb(216, 76, 255)', 'rgb(255, 255, 255)']

	validates :name, length: { maximum: 26 }
  validates :colour, inclusion: { in: colours }
  validates :admin, presence: true

  def is_a_member?(user)
    self.members.each { |member| return true if member == user }
    false
  end
end
