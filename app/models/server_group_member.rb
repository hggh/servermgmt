class ServerGroupMember < ActiveRecord::Base
	belongs_to :server_group
	belongs_to :server
end
