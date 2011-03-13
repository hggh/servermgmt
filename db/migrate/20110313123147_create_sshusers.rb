class CreateSshusers < ActiveRecord::Migration
  def self.up
    create_table :sshusers do |t|
      t.string :username
      t.integer :server_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sshusers
  end
end
