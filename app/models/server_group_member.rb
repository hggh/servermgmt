class ServerGroupMember < ActiveRecord::Base
	belongs_to :server_group
	belongs_to :server
  
  validates_presence_of :server_group_id
  validates_presence_of :server_id
end
