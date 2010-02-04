class CreateServerGroups < ActiveRecord::Migration
  def self.up
    create_table :server_groups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :server_groups
  end
end
