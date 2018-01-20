class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :group_members, dependent: :destroy
  # has_many :groups, through: :group_members
  has_many :groups

  has_many :friends

  def full_name
  	"#{self.first_name} #{self.last_name}"
  end

  def members
    self.group_members.map { |member| member.group }
  end

  def group_admin?(group)
    self == group.admin ? true : false
  end
end
