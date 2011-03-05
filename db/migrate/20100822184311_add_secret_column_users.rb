class AddSecretColumnUsers < ActiveRecord::Migration
  def self.up
     add_column :users, :secret_key, :string
  end

  def self.down
     remove_column :users, :secret_key
  end
end
