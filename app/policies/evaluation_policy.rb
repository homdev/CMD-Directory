class EvaluationPolicy < ApplicationPolicy
    def create?
      user.admin? || user.moderator? || user.member? # Les rôles autorisés à créer des évaluations
    end
  
    def update?
      user.admin? || (record.evaluator == user) # Seuls les admins et l'évaluateur peuvent mettre à jour
    end
  
    def destroy?
      user.admin? || (record.evaluator == user) # Seuls les admins et l'évaluateur peuvent supprimer
    end
  
    def show?
      true # Tout le monde peut voir une évaluation
    end
  end
  