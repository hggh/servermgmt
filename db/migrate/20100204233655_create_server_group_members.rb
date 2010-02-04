class CreateServerGroupMembers < ActiveRecord::Migration
  def self.up
    create_table :server_group_members do |t|
      t.integer :server_group_id
      t.integer :server_id

      t.timestamps
    end
  end

  def self.down
    drop_table :server_group_members
  end
end
