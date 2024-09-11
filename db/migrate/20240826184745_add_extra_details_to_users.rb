class AddExtraDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :profession, :string
    add_column :users, :phone_number, :string
  end
end
