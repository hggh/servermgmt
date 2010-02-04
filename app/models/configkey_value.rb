class ConfigkeyValue < ActiveRecord::Base
  belongs_to :configkey
  belongs_to :server
  # FIXME: , :group_id
  
  validates_presence_of :configkey_id
  validates_presence_of :value
  
  validates_uniqueness_of :configkey_id, :scope => [ :server_id ]
end
