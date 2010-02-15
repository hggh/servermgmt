class Configkey < ActiveRecord::Base
  default_scope :order => :name
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 5
  
  has_many :configkey_values, :dependent => :destroy
  
  
  def self.getKeysforServer(server_id)
   Configkey.find(:all, :joins => " LEFT JOIN (SELECT * FROM configkey_values WHERE configkey_values.server_id  = #{server_id}) AS tmp ON configkeys.id = tmp.configkey_id", :conditions => "tmp.server_id IS NULL")
  end

  def self.getKeysforServerGroup(server_group_id)
   Configkey.find(:all, :joins => " LEFT JOIN (SELECT * FROM configkey_values WHERE configkey_values.server_group_id  = #{server_group_id}) AS tmp ON configkeys.id = tmp.configkey_id", :conditions => "tmp.server_group_id IS NULL")
  end
end
