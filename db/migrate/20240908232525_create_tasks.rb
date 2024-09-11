class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :assigned_to
      t.string :status
      t.date :due_date
      t.string :priority

      t.timestamps
    end
  end
end
