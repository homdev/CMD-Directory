class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name
      t.text :description
      t.string :status, default: "idea" # idea, startup, scaling
      t.integer :funding_needed
      t.string :sector
      
      t.timestamps
    end
  end
end
