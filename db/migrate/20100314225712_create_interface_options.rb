class CreateInterfaceOptions < ActiveRecord::Migration
  def self.up
    create_table :interface_options do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :interface_options
  end
end
