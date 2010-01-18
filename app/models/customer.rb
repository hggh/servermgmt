class Customer < ActiveRecord::Base
	has_many :servers
  has_many :domains
    
    
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
end
