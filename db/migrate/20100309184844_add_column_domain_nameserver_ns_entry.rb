class AddColumnDomainNameserverNsEntry < ActiveRecord::Migration
  def self.up
    add_column :domain_nameservers, :ns_entry, :integer, :default => 0, :limit => 1, :null => false 
  end

  def self.down
    remove_column :domain_nameservers, :ns_entry
  end
end
