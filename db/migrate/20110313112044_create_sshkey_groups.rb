class CreateSshkeyGroups < ActiveRecord::Migration
  def self.up
    create_table :sshkey_groups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :sshkey_groups
  end
end
