class Network < ActiveRecord::Base
	validates_format_of :network, :with => /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}$/, :on => :save
	validates_presence_of :comment
	validates_length_of :comment, :minimum => 5
	has_many :ips
	before_destroy :ensure_not_used
end
