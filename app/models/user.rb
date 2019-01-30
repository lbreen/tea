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
  has_many :drinks, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def members
    group_members.map(&:group)
  end

  def group_admin?(group)
    group.admin == self
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
    friendships = Friendship.select { |f| f.user_id == id || f.friend_id == id }.select { |f| f.status == status }

    friend_ids = friendships.flat_map { |f| [f.user_id, f.friend_id] }.uniq.delete_if { |user_id| user_id == id }

    friend_ids.map! { |id| User.find(id) }
  end

  def friend_requests
    Friendship.select { |f| f.friend_id == id && f.status == "pending" }
  end
end
