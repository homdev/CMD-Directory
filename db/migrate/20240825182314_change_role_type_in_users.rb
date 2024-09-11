class ChangeRoleTypeInUsers < ActiveRecord::Migration[7.2]
  def up
    # Ajouter une colonne temporaire avec le nouveau type
    add_column :users, :new_role, :integer, default: 0

    # Copier les valeurs existantes de la colonne role
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:new_role, user.role.to_i) if user.role.present?
    end

    # Supprimer l'ancienne colonne et renommer la nouvelle
    remove_column :users, :role
    rename_column :users, :new_role, :role
  end

  def down
    # Pour inverser, ajoutez de nouveau la colonne string
    add_column :users, :old_role, :string

    # Copier les valeurs de l'entier vers la chaîne de caractères
    User.reset_column_information
    User.find_each do |user|
      user.update_column(:old_role, user.role.to_s) if user.role.present?
    end

    # Supprimer la colonne actuelle et renommer la colonne temporaire
    remove_column :users, :role
    rename_column :users, :old_role, :role
  end
end
