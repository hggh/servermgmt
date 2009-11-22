class Iptype < ActiveRecord::Base
	has_many :ips
	before_destroy :ensure_not_used
end
