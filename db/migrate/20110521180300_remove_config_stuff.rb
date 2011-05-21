class RemoveConfigStuff < ActiveRecord::Migration
  def self.up
    drop_table :configkey_values
    drop_table :configkeys
  end

  def self.down
  end
end
