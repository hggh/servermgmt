class AddAutoColumnOnServerGroupMembers < ActiveRecord::Migration
  def self.up
    add_column :server_group_members, :auto_add, :boolean, :default => false
  end

  def self.down
    remove_column :server_group_members, :auto_add
  end
end
