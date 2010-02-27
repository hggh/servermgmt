class CreateNameservers < ActiveRecord::Migration
  def self.up
    create_table :nameservers do |t|
      t.string :name
      t.inet :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :nameservers
  end
end
