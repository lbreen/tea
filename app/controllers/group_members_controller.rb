class GroupMembersController < ApplicationController
  def new
  end

  def create
    members = member_ids.map { |id| User.find(id) }

    members.each do |member|
      group_member = GroupMember.new(
        group_id: params[:group_id],
        user_id: member.id
      )
      authorize group_member
      group_member.save
    end

    redirect_to group_path(Group.find(params[:group_id]))
  end

  def destroy
  end

  private

  def member_ids
    params[:group_member][:user_id].delete('')
    params[:group_member][:user_id]
  end
end
