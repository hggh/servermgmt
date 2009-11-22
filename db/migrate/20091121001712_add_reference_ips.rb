class AddReferenceIps < ActiveRecord::Migration
  def self.up
  	add_column :ips, :iptype_id, :integer
  end

  def self.down
  	remove_column iptype_id
  end
end
