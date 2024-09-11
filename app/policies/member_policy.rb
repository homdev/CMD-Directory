class MemberPolicy < ApplicationPolicy
    def index?
      user.member? || user.admin?
    end
  
    def show?
      user.member? || user.admin?
    end
  end
  