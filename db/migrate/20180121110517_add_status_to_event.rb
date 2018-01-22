class AddStatusToEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :status, foreign_key: true, :default => 1
  end
end
