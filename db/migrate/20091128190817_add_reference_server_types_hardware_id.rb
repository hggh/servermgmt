class AddReferenceServerTypesHardwareId < ActiveRecord::Migration
  def self.up
  	add_column :servertypes, :server_type_hardware_id, :integer
  end

  def self.down
  	remove_column :servertypes, :server_type_hardware_id
  end
end
