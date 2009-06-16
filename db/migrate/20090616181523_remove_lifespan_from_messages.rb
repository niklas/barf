class RemoveLifespanFromMessages < ActiveRecord::Migration
  def self.up
    remove_column :messages, :lifespan
  end

  def self.down
    add_column :messages, :lifespan, :integer
  end
end
