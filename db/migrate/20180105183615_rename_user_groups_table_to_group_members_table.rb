class RenameUserGroupsTableToGroupMembersTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :user_groups, :group_members
  end
end
