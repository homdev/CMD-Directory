class ProjectMemberPolicy < ApplicationPolicy
    def create?
      user.admin? || record.project.project_leader == user
    end
  
    def destroy?
      user.admin? || record.project.project_leader == user
    end
  end
  