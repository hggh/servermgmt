class CreateServertyps < ActiveRecord::Migration
  def self.up
    create_table :servertyps do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :servertyps
  end
end
