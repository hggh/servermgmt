class AddDomainsTable < ActiveRecord::Migration
  def self.up
     create_table :domains do |t|
        t.string :name
        t.integer :serial
        t.timestamps
     end
  end

  def self.down
  end
end
