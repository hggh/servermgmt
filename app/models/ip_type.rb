class IpType < ActiveRecord::Base
	has_many :ips
  validates_presence_of :name
end
