class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :group_members, dependent: :destroy
  # has_many :groups, through: :group_members
  has_many :groups

  has_many :friendships, dependent: :destroy

  def full_name
  	"#{self.first_name} #{self.last_name}"
  end

  def members
    self.group_members.map { |member| member.group }
  end

  def group_admin?(group)
    self == group.admin ? true : false
  end

  def pending_friends
    retrieve_friends('pending')
  end

  def accepted_friends
    retrieve_friends('accepted')
  end

  def declined_friends
    retrieve_friends('declined')
  end

  def blocked_friends
    retrieve_friends('blocked')
  end

  def retrieve_friends(status)
    friendships = Friendship.select{ |f| f.user == self || f.friend == self }.select { |f| f.status == status }

    friendships.map { |f| [f.user, f.friend] }.flatten.uniq.delete_if { |user| user == self }
  end
end
