class CreateSshuserMbrs < ActiveRecord::Migration
  def self.up
    create_table :sshuser_mbrs do |t|
      t.integer :sshuser_id
      t.integer :sshkey_id
      t.integer :sshkey_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sshuser_mbrs
  end
end
