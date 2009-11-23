class Ip < ActiveRecord::Base
	belongs_to :network
	belongs_to  :iptype
end
