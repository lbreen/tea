class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.select { |group| group.is_a_member?(user) }
    end
  end

  def create?
    user
  end

  def update?
    super # Need to change this
  end

  def destroy?
    super # Need to change this
  end
end
