class CreateConfigkeyValues < ActiveRecord::Migration
  def self.up
    create_table :configkey_values do |t|
      t.integer :configkey_id
      t.text :value
      t.integer :server_id
      t.integer :server_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :configkey_values
  end
end
