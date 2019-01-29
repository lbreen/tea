class FriendshipsController < ApplicationController
  before_action :find_friendship, only: [:update]

  def index
    @users = policy_scope(User).reject { |user| user == current_user }
  end

  def create
    @friendship = Friendship.new(user: current_user, friend: find_user)
    authorize @friendship
    @friendship.save
    redirect_to(request.env['HTTP_REFERER'])
  end

  def update
    @friendship.update(status: params[:status])

    flash[:alert] = "An error has occured." unless @friendship.save

    respond_to do |format|
      format.html { redirect_to request.env['HTTP_REFERER'] }
      format.js
    end
  end

  private

  def find_user
    User.find(params[:user_id])
  end

  def find_friendship
    @friendship = Friendship.find(params[:id])
    authorize @friendship
  end
end
