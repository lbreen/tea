class GroupMemberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.group.admin == user
  end

  def destroy?
    # Only the admin or the user themselves can remove the user
    record.group.admin == user || record.member == user
  end
end
