class ChangeTableNetworksNet < ActiveRecord::Migration
  def self.up
    remove_column :networks, :network
    add_column :networks, :network, :cidr
  end

  def self.down
    remove_column :networks, :network
    add_column :networks, :network, :string
  end
end
