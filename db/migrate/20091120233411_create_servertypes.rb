class CreateServertypes < ActiveRecord::Migration
  def self.up
    create_table :servertypes do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :servertypes
  end
end
