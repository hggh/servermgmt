class AddServerGroupsColumnOnSshUsers < ActiveRecord::Migration
  def self.up
    add_column :sshusers, :server_group_id, :integer
  end

  def self.down
    remove_column :sshusers, :server_group_id
  end
end
