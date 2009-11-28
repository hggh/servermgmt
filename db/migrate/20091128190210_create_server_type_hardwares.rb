class CreateServerTypeHardwares < ActiveRecord::Migration
  def self.up
    create_table :server_type_hardwares do |t|
      t.string :name

      t.timestamps
    end
    ServerTypeHardware.create :name => 'Hardware'
    ServerTypeHardware.create :name => 'Virtual'
    ServerTypeHardware.create :name => 'n/a'
  end

  def self.down
    drop_table :server_type_hardwares
  end
end
