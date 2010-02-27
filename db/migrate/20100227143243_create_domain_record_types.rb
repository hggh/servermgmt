class CreateDomainRecordTypes < ActiveRecord::Migration
  def self.up
    create_table :domain_record_types do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_record_types
  end
end
