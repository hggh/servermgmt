class RemoveServerTypeHardware < ActiveRecord::Migration
  def self.up
    remove_column :servertypes, :server_type_hardware_id
    drop_table :server_type_hardwares
  end

  def self.down
  end
end
