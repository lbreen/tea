class GroupMembersController < ApplicationController
  def new
  end

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

    authorize @group_member

    @group_member.delete

    if @user == @group.admin
      # Transfer admin rights, if admin and redirect to group#index
      @group.admin = @group.members.first
      @group.save
      redirect_to groups_path
    elsif @user == current_user
      # User is removing themselves and needs to redirect to group#index
      redirect_to groups_path
    else
      # Member has been removed by admin
      redirect_to group_path(@group)
    end
  end

  private

  def user_params
    params[:group_member][:user_id].delete('')
    params[:group_member][:user_id]
  end
end
