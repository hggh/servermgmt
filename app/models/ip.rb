class Ip < ActiveRecord::Base
	belongs_to :network
	belongs_to  :iptype
	validates_presence_of :ip
	validates_uniqueness_of :ip
end
