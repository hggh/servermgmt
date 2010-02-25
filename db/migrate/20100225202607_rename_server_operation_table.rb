class RenameServerOperationTable < ActiveRecord::Migration
  def self.up
    rename_table :serveroperationsystems, :server_operation_systems
  end

  def self.down
    rename_table :server_operation_systems, :serveroperationsystems
  end
end
