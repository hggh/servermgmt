class AddCustomerReferenceonDomains < ActiveRecord::Migration
  def self.up
     add_column :domains, :customer_id, :integer
  end

  def self.down
  end
end
