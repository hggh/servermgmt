class CreateConfigkeys < ActiveRecord::Migration
  def self.up
    create_table :configkeys do |t|
      t.string :name
      t.string :default

      t.timestamps
    end
  end

  def self.down
    drop_table :configkeys
  end
end
