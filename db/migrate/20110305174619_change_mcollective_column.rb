class ChangeMcollectiveColumn < ActiveRecord::Migration
  def self.up
    remove_column :nameservers, :mcollective
    add_column :nameservers, :mcollective_host, :string, :limit => 100, :null => true, :default => nil
  end

  def self.down
  end
end
