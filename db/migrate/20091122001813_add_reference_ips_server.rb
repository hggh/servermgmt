class AddReferenceIpsServer < ActiveRecord::Migration
  def self.up
  	add_column :ips, :server_id, :integer
  end

  def self.down
  	remove_column server_id
  end
end
