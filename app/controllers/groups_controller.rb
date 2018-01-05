class GroupsController < ApplicationController
  before_action :colours, only: [:new, :create]
  before_action :find_group, only: [:show, :add_member]

  def index
    @groups = policy_scope(Group)
  end

  def show
    @new_group_member = GroupMember.new
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
    @group.admin = current_user
    @group.users = user_id_params.map { |id| User.find(id) } + [current_user]

    authorize @group
    if @group.save!
      redirect_to groups_path
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
    params.require(:group).permit(:name, :colour, :user_ids)
  end

  def user_id_params
    params[:group][:user_ids].delete('')
    params[:group][:user_ids]
  end

  def colours
    @colours = ['rgb(255, 255, 255)', 'rgb(255, 45, 45)', 'rgb(97, 216, 249)', 'rgb(72, 48, 255)', 'rgb(0, 165, 35)', 'rgb(216, 76, 255)']
  end

  def find_group
    @group = Group.find(params[:id])
    authorize @group
  end
end
