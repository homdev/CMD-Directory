class RemoveRisksFromProjects < ActiveRecord::Migration[7.2]
  def change
    remove_column :projects, :risks, :text
  end
end
