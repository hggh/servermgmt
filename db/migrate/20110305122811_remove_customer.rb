class RemoveCustomer < ActiveRecord::Migration
  def self.up
    drop_table :customers
    remove_column :servers, :customer_id
    remove_column :networks, :customer_id
    remove_column :domains, :customer_id
  end

  def self.down
  end
end
