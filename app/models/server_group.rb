class ServerGroup < ActiveRecord::Base
	validates_presence_of :name
	validates_length_of :name, :minimum => 3

	has_many :server_group_members, :dependent => :destroy
	has_many :configkey_values, :dependent => :destroy

end
