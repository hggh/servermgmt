class AddCustomterToNetworks < ActiveRecord::Migration
  def self.up
    add_column :networks, :customer_id, :integer
  end

  def self.down
    remove_column :networks, :customer_id
  end
end
