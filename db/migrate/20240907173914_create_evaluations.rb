class CreateEvaluations < ActiveRecord::Migration[7.2]
  def change
    create_table :evaluations do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :maturity_level, null: false
      t.text :feedback
      t.references :evaluator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
