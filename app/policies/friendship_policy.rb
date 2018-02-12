class FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.accepted_friends
    end
  end

  def create?
    user == record.user
  end

  def update?
    user == record.friend
  end
end
