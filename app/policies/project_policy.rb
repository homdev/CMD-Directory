class ProjectPolicy < ApplicationPolicy
    def index?
      true # Tout le monde peut voir la liste des projets
    end
  
    def show?
      true # Tout le monde peut voir un projet spécifique
    end
  
    def create?
      user.admin? || user.member? # Seuls les admins ou membres peuvent créer des projets
    end
  
    def update?
      user.admin? || (user.member? && record.user == user) # Admins ou créateur du projet peuvent mettre à jour
    end
  
    def destroy?
      user.admin? || (user.member? && record.user == user) # Admins ou créateur du projet peuvent supprimer
    end
  end
  