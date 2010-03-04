class AddColumnsDomainRecordsValueSource < ActiveRecord::Migration
  def self.up
    add_column :domain_records, :source, :string
    add_column :domain_records, :value, :string
    add_column :domain_records, :extra_value, :string
  end

  def self.down
    remove_column :domain_records, :source
    remove_column :domain_records, :value
    remove_column :domain_records, :extra_value
  end
end
