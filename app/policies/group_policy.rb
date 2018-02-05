class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.select { |group| group.is_a_member?(user) || user.group_admin?(group) }
    end
  end

  def show?
    record.is_a_member?(user) || user.group_admin?(record)
  end

  def create?
    user
  end

  # def update?
  #   super # Need to change this
  # end

  # def destroy?
  #   super # Need to change this
  # end
end
