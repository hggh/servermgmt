class AddColumnRecordType < ActiveRecord::Migration
  def self.up
    add_column :domain_record_types, :extra_value, :boolean, { :default => "false"}
  end

  def self.down
    remove_column :domain_record_types, :extra_value
  end
end
