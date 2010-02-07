class ServerGroupMember < ActiveRecord::Base
	belongs_to :server_group
	belongs_to :server
  
  validates_presence_of :server_group_id
  validates_presence_of :server_id
  
  validates_uniqueness_of :server_id, :scope => :server_group_id
end
