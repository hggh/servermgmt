class RemoveServerDomains < ActiveRecord::Migration
  def self.up
     drop_table :server_domains
     rename_column :servers, :server_domain_id, :domain_id
  end

  def self.down
  end
end
