class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :name
      t.boolean :only_admin, :default => false
      t.boolean :only_logged, :default => false
      t.timestamps
    end
  end
end
