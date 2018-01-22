class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :is_admin, :boolean, :default => false
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :money, :decimal, :default => 0.0
  end
end