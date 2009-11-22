class Ip < ActiveRecord::Base
	belongs_to :network
	belongs_to  :iptype
	before_destroy :ensure_not_used
end
