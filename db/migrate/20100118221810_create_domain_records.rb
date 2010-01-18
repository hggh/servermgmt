class CreateDomainRecords < ActiveRecord::Migration
  def self.up
    create_table :domain_records do |t|
      t.integer :ttl
      t.integer :domain_id

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_records
  end
end
