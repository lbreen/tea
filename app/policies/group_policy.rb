class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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
