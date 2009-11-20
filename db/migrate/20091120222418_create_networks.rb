class CreateNetworks < ActiveRecord::Migration
  def self.up
    create_table :networks do |t|
      t.column :network, :cidr
      t.column :comment, :string

      t.timestamps
    end
  end

  def self.down
    drop_table :networks
  end
end
