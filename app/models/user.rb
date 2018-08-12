class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :group_members, dependent: :destroy
  # has_many :groups, through: :group_members
  has_many :groups
  has_many :messages, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :drink_notifications, dependent: :destroy
  has_many :drink_requests, dependent: :destroy

  validates :first_name, :last_name, presence: true

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
    friendships = Friendship.select{ |f| f.user_id == self.id || f.friend_id == self.id }.select { |f| f.status == status }

    friend_ids = friendships.map { |f| [f.user_id, f.friend_id] }.flatten.uniq.delete_if { |user_id| user_id == self.id }

    friend_ids.map! { |id| User.find(id) }
  end

  def friend_requests
    Friendship.select { |f| f.friend_id == self.id && f.status == "pending"}
  end
end
