class CreateSshkeys < ActiveRecord::Migration
  def self.up
    create_table :sshkeys do |t|
      t.string :name
      t.text :key_public
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :sshkeys
  end
end
