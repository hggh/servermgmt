class CreateDomainSoas < ActiveRecord::Migration
  def self.up
    create_table :domain_soas do |t|
      t.integer :domain_id
      t.integer :ttl
      t.string :primary_ns
      t.string :mail
      t.integer :refresh
      t.integer :retry
      t.integer :expire
      t.integer :negative_ttl

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_soas
  end
end
