class Server < ActiveRecord::Base
	belongs_to :servertype
	has_many :ips, :dependent => :destroy
end
