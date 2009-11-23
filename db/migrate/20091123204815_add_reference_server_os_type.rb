class AddReferenceServerOsType < ActiveRecord::Migration
  def self.up
  	add_column :servers, :serveroperationsystem_id, :integer
  end

  def self.down
  end
end
