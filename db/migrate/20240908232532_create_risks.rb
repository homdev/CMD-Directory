class CreateRisks < ActiveRecord::Migration[7.2]
  def change
    create_table :risks do |t|
      t.references :project, null: false, foreign_key: true
      t.text :description
      t.string :likelihood
      t.string :impact
      t.text :mitigation_plan

      t.timestamps
    end
  end
end
