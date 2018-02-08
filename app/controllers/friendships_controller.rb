class FriendshipsController < ApplicationController

  def index
    @users = policy_scope(User).reject { |user| user == current_user}
  end

  def create
    @friendship = Friendship.new(user: current_user, friend: find_user)
    authorize @friendship
    @friendship.save
    redirect_to friendships_path
  end

  private

  def find_user
    User.find(params[:user_id])
  end
end
