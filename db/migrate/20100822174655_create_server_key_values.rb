class CreateServerKeyValues < ActiveRecord::Migration
  def self.up
    create_table :server_key_values do |t|
      t.integer :server_id
      t.integer :server_key_id
      t.text :kvalue

      t.timestamps
    end
  end

  def self.down
    drop_table :server_key_values
  end
end
