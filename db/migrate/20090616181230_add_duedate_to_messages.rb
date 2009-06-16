class AddDuedateToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :due_at, :datetime
  end

  def self.down
    add_column :messages, :due_at
  end
end
