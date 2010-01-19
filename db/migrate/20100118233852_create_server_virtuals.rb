class CreateServerVirtuals < ActiveRecord::Migration
  def self.up
    create_table :server_virtuals do |t|
      t.integer :hardware_id
      t.integer :virtual_id

      t.timestamps
    end
  end

  def self.down
    drop_table :server_virtuals
  end
end
