class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :address
      t.decimal :price_low
      t.decimal :price_high
      t.date :event_date
      t.integer :max_seats_number
      t.boolean :adults_only
      t.timestamps
    end
  end
end
