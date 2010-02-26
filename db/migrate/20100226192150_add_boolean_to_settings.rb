class AddBooleanToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :boolean, :integer, :default => 0
  end

  def self.down
    remove_column :settings, :boolean
  end
end
