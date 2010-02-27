class CreateDomainNameservers < ActiveRecord::Migration
  def self.up
    create_table :domain_nameservers do |t|
      t.integer :nameserver_id
      t.integer :domain_id
      t.boolean :primary_ns

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_nameservers
  end
end
