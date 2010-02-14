class RenameColumnIpType < ActiveRecord::Migration
  def self.up
    rename_column :ips, :iptype_id, :ip_type_id
  end

  def self.down
    rename_column :ips,:ip_type_id, :iptype_id 
  end
end
