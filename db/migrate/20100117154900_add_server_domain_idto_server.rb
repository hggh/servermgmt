class AddServerDomainIdtoServer < ActiveRecord::Migration
  def self.up
    add_column :servers, :server_domain_id, :integer
  end

  def self.down
     remove_column :servers, :server_domain_id
  end
end
