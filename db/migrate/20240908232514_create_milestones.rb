class CreateMilestones < ActiveRecord::Migration[7.2]
  def change
    create_table :milestones do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.date :due_date

      t.timestamps
    end
  end
end
