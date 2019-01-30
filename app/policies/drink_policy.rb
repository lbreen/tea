class DrinkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.group.a_member?(user) || user.group_admin?(record.group)
  end

  def create?
    record.group.a_member?(user) || user.group_admin?(record.group)
  end

  def update?
    user == record.user
  end
end
