class GroupsController < ApplicationController
  before_action :colours, only: [:new, :create]
  before_action :find_group, only: [:show, :add_member]

  def index
    @groups = policy_scope(Group)
  end

  def show
    @group_member = GroupMember.new
    @members = @group.members.sort { |x, y| x.first_name <=> y.first_name }
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @group.admin = current_user
    @group.members = user_id_params.map { |id| User.find(id) } + [current_user]

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

  def add_member

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
    @colours = ['rgb(255, 255, 255)', 'rgb(255, 45, 45)', 'rgb(97, 216, 249)', 'rgb(72, 48, 255)', 'rgb(0, 165, 35)', 'rgb(216, 76, 255)']
  end

  def find_group
    @group = Group.find(params[:id])
    authorize @group
  end
end
