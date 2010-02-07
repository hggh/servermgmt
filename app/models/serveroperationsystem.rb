class Serveroperationsystem < ActiveRecord::Base
	has_many :servers
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
