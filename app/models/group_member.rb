class GroupMember< ApplicationRecord
  belongs_to :member, class_name: "User", foreign_key: "user_id"
  belongs_to :group
end
