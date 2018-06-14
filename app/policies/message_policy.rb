class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # user == a group instance
      scope.where(group_id: user.id)
    end
  end

  def create?
    true
  end
end
