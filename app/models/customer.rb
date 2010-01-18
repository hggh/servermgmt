class Customer < ActiveRecord::Base
	has_many :servers
  has_many :domains
end
