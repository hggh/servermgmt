class CreateIps < ActiveRecord::Migration
  def self.up
    create_table :ips do |t|
      t.column :ip, :inet
      t.references :network

      t.timestamps
    end
  end

  def self.down
    drop_table :ips
  end
end
