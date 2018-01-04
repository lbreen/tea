class GroupsController < ApplicationController
  before_action :colours, only: [:new, :create]

  def index
    @groups = policy_scope(Group)
  end

  def new
    @group = Group.new
    authorize @group
  end

  def create
    @group = Group.new(group_params)
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

  private

  def group_params
    params.require(:group).permit(:name, :colour)
  end

  def colours
    @colours = ['rgb(255, 255, 255)', 'rgb(255, 45, 45)', 'rgb(97, 216, 249)', 'rgb(72, 48, 255)', 'rgb(0, 165, 35)', 'rgb(216, 76, 255)']
  end

  def authorize_group
    authorize @group
  end
end
