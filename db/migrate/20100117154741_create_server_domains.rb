class CreateServerDomains < ActiveRecord::Migration
  def self.up
    create_table :server_domains do |t|
      t.string :name
      t.integer :serial

      t.timestamps
    end
  end

  def self.down
    drop_table :server_domains
  end
end
