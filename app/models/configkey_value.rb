class ConfigkeyValue < ActiveRecord::Base
  belongs_to :configkey
  belongs_to :server
  belongs_to :server_group
  
  validates_presence_of :configkey_id
  validates_presence_of :value
  
  validates_uniqueness_of :configkey_id, :scope => [ :server_id, :server_group_id ]
end
