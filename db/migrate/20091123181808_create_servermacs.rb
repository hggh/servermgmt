class CreateServermacs < ActiveRecord::Migration
  def self.up
    create_table :servermacs do |t|
      t.string :comment
      t.column :mac, :macaddr
      t.references :server

      t.timestamps
    end
  end

  def self.down
    drop_table :servermacs
  end
end
