class DrinkResponsePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    is_a_member = record.drink.group.a_member?(user) || user.group_admin?(record.drink.group)
    is_not_drink_creator = record.user != record.drink.user

    is_a_member && is_not_drink_creator
  end
end
