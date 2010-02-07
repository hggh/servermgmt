class AddPrimaryToIPs < ActiveRecord::Migration
  def self.up
     add_column :ips, :is_primary, :integer
  end

  def self.down
     remove_column :ips, :is_primary
  end
end
