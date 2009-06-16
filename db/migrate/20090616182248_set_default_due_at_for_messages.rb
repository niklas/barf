class SetDefaultDueAtForMessages < ActiveRecord::Migration
  def self.up
    Message.update_all('due_at = created_at', 'due_at IS NULL')
  end

  def self.down
  end
end
