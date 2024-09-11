class CreateContactRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_requests do |t|
      t.references :sender, foreign_key: { to_table: :users }, null: false
      t.references :receiver, foreign_key: { to_table: :users }, null: false
      t.string :status, default: "pending" # pending, accepted, rejected

      t.timestamps
    end
  end
end
