class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :address
      t.string :seat_id_seq
      t.decimal :price
      t.string :email_address
      t.date :sale_date
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
