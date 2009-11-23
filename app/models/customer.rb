class Customer < ActiveRecord::Base
	has_many :servers
end
