class CreateDomainOptionValues < ActiveRecord::Migration
  def self.up
    create_table :domain_option_values do |t|
      t.integer :domain_id
      t.integer :domain_option_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_option_values
  end
end
