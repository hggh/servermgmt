class ServerChangeColumnServerOp < ActiveRecord::Migration
  def self.up
    rename_column :servers, :serveroperationsystem_id, :server_operation_system_id
  end

  def self.down
    rename_column :servers, :server_operation_system_id, :serveroperationsystem_id 
  end
end
