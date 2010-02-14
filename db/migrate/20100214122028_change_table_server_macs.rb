class ChangeTableServerMacs < ActiveRecord::Migration
  def self.up
     rename_table('servermacs', 'server_macs')
  end

  def self.down
     rename_table('server_macs', 'servermacs')
  end
end
