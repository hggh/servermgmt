class RenameTableIpTypes < ActiveRecord::Migration
  def self.up
    rename_table('iptypes', 'ip_types')
  end

  def self.down
    rename_table('ip_types','iptypes')
  end
end
