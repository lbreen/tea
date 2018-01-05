class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :groups

  def full_name
  	"#{self.first_name} #{self.last_name}"
  end

  def group_admin?(group)
    self == group.admin ? true : false
  end
end
