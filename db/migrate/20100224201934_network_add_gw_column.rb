
class NetworkAddGwColumn < ActiveRecord::Migration
  def self.up
    add_column :networks, :gw, :inet
  end

  def self.down
    remove_column :networks, :gw
  end
end
