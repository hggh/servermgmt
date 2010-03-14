class CreateServerInterfaces < ActiveRecord::Migration
  def self.up
    create_table :server_interfaces do |t|
      t.integer :server_id
      t.integer :interface_id
      t.integer :vlan_id
      t.integer :ip_id
      t.boolean :alias
      t.boolean :default_gw

      t.timestamps
    end
  end

  def self.down
    drop_table :server_interfaces
  end
end
