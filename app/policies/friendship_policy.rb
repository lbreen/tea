class FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.accepted_friends
    end
  end
end
