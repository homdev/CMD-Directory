module Admin
  class AdminPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all if user.admin?
      end
    end

    def index?
      user.admin?
    end

    def show?
      user.admin?
    end

    def create?
      user.admin?
    end

    def new?
      create?
    end

    def update?
      user.admin?
    end

    def edit?
      user.admin?
    end

    def destroy?
      user.admin?
    end
  end
end
