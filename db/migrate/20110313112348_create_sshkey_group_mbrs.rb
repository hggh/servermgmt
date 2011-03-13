class CreateSshkeyGroupMbrs < ActiveRecord::Migration
  def self.up
    create_table :sshkey_group_mbrs do |t|
      t.integer :sshkey_id
      t.integer :sshkey_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sshkey_group_mbrs
  end
end
