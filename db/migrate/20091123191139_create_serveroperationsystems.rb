class CreateServeroperationsystems < ActiveRecord::Migration
  def self.up
    create_table :serveroperationsystems do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :serveroperationsystems
  end
end
