class GroupsController < ApplicationController
  def index
    @groups = policy_scope(Group).order(created_at: :desc)
  end

  def new
  end

  def create
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

  def authorize_group
    authorize @group
  end
end
