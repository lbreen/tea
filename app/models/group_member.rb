class GroupMember< ApplicationRecord
  belongs_to :member, class_name: "User", foreign_key: "user_id"
  belongs_to :group

  # before_create :users_are_friends

  # def users_are_friends
  #   admin = self.group.admin
  #   member = self.member

  #   if member.accepted_friends.include? admin == false

  #   else

  #   end
  # end
end
