class AddMcollectiveColumnNameServer < ActiveRecord::Migration
  def self.up
     add_column :nameservers, :mcollective, :boolean, :default => true
  end

  def self.down
     remove_column :nameservers, :mcollective
  end
end
