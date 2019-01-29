class GroupMember < ApplicationRecord
  belongs_to :member, class_name: "User", foreign_key: "user_id"
  belongs_to :group

  before_create :users_are_friends

  def users_are_friends
    admin = group.admin
    member = self.member

    return true if member.accepted_friends.include? admin

    raise "You can only invite friends to your group."
  end
end
