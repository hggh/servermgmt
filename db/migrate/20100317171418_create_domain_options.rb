class CreateDomainOptions < ActiveRecord::Migration
  def self.up
    create_table :domain_options do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :domain_options
  end
end
