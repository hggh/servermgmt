class ChangeTableIpColumnIp < ActiveRecord::Migration
  def self.up
    remove_column :ips, :ip
    add_column :ips, :ip, :inet
  end

  def self.down
    remove_column :ips, :ip
    add_column :ips, :ip, :string
  end
end
