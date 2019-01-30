class GroupsController < ApplicationController
  before_action :colours, only: %i[new create]
  before_action :find_group, only: [:show]

  def index
    @groups = policy_scope(Group)
    @friends = policy_scope(Friendship)
  end

  def show
    @group_member = GroupMember.new
    @members = @group.members.to_a + [@group.admin]
    @members.sort! { |x, y| x.first_name <=> y.first_name }
    @group_statistics = group_statistics
    @message = Message.new
    @messages = @group.messages.reverse_order.page.reverse
    @drink = @group.drink_in_progress if @group.drink_in_progress # This logic could be better, consider attr_reader
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @group.admin = current_user
    @group.members = user_id_params.map { |id| User.find(id) }

    authorize @group
    if @group.save!
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :colour, :member_ids)
  end

  def user_id_params
    params[:group][:member_ids].delete('')
    params[:group][:member_ids]
  end

  def colours
    @colours = [
      'rgb(255, 255, 255)',
      'rgb(255, 45, 45)',
      'rgb(97, 216, 249)',
      'rgb(72, 48, 255)',
      'rgb(0, 165, 35)',
      'rgb(216, 76, 255)'
    ]
  end

  def find_group
    @group = Group.find(params[:id])
    authorize @group
  end

  def group_statistics
    { 'Total drinks made' => 0, 'Avg. person per round' => 0, 'Hours since last brew' => 0 }
  end
end
