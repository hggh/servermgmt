class CreateServerKeys < ActiveRecord::Migration
  def self.up
    create_table :server_keys do |t|
      t.string :ktype

      t.timestamps
    end
  end

  def self.down
    drop_table :server_keys
  end
end
