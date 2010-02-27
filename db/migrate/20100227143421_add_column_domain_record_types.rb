class AddColumnDomainRecordTypes < ActiveRecord::Migration
  def self.up
    add_column :domain_records, :domain_record_type_id, :integer
  end

  def self.down
    remove_column :domain_records, :domain_record_type_id
  end
end
