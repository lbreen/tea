class GroupMembersController < ApplicationController
  def create
    members = user_params.map { |id| User.find(id) }

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
    @group_member = GroupMember.where(group_id: params[:group_id], user_id: params[:id])[0]
    @group = Group.find(params[:group_id])
    @user = User.find(params[:id])

    if @user == @group.admin
      remove_admin
    elsif @user == current_user
      authorize @group_member

      @group_member.delete
      # User is removing themselves and needs to redirect to group#index
      redirect_to groups_path
    else
      authorize @group_member

      @group_member.delete
      # Member has been removed by admin
      redirect_to group_path(@group)
    end
  end

  private

  def user_params
    params[:group_member][:user_id].delete('')
    params[:group_member][:user_id]
  end

  def remove_admin
    # Transfer admin rights, if admin and redirect to group#index
    authorize @group
    @group.admin = @group.members.first
    @group.save
    redirect_to groups_path
  end
end
