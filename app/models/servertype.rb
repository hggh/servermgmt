class Servertype < ActiveRecord::Base
	has_many :servers
  belongs_to :server_type_hardware
end
