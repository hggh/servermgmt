class AddPreseedConfigurationPerOs < ActiveRecord::Migration
  def self.up
    add_column :serveroperationsystems, :config_preseed, :text
  end

  def self.down
    remove_column :serveroperationsystems, :config_preseed, :text
  end
end
