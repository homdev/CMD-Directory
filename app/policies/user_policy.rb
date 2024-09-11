class UserPolicy < ApplicationPolicy
  def index?
    user.admin? || user.member?
  end

  def show?
    user.admin? || record == user || user.member? # Les admins et les membres peuvent voir n'importe quel membre, les utilisateurs peuvent voir leur propre compte
  end

  def update?
    user.admin? || record == user
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.member?
        scope.where(role: :member)
      else
        scope.none
      end
    end
  end
end
