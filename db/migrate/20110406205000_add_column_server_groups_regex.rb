class AddColumnServerGroupsRegex < ActiveRecord::Migration
  def self.up
    add_column :server_groups, :group_regex, :text
  end

  def self.down
    remove_column :server_groups, :group_regex
  end
end
