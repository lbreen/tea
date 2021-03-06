class Group < ApplicationRecord
  after_initialize :default_colour

  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members
  belongs_to :admin, class_name: 'User', foreign_key: 'user_id'
  has_many :messages, dependent: :destroy

  colours = [
    'rgb(255, 45, 45)',
    'rgb(97, 216, 249)',
    'rgb(72, 48, 255)',
    'rgb(0, 165, 35)',
    'rgb(216, 76, 255)',
    'rgb(255, 255, 255)'
  ]

  validates :name, length: { maximum: 26 }
  validates :colour, inclusion: { in: colours }
  validates :admin, presence: true

  def a_member?(user)
    members.each { |member| return true if member == user }
    false
  end

  def default_colour
    self.colour = 'rgb(255, 255, 255)' if colour.nil?
  end
end
