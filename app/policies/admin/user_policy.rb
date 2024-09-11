module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      Rails.logger.debug { "User role: #{user.role}" }
      user.admin?
    end

    def show?
      Rails.logger.debug { "User role: #{user.role}" }
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

    class Scope < Scope
      def resolve
        if @user.admin?
          @scope.all
        else
          @scope.none
        end
      end
    end
  end
end
