class AddDetailsToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
    add_column :projects, :progress, :integer
    add_column :projects, :team_size, :integer
    add_column :projects, :funding_received, :decimal
    add_column :projects, :risks, :text
    add_column :projects, :opportunities, :text
    add_column :projects, :milestones, :text
    add_column :projects, :project_leader_id, :integer
    add_column :projects, :impact, :text
    add_column :projects, :status_update, :text
  end
end
