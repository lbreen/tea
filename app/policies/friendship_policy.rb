class FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.accepted_friends
    end
  end

  def create?
    user.id == record.user_id
  end
end
