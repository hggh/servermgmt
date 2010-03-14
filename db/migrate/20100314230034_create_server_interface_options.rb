class CreateServerInterfaceOptions < ActiveRecord::Migration
  def self.up
    create_table :server_interface_options do |t|
      t.integer :interface_option_id
      t.integer :server_interface_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :server_interface_options
  end
end
