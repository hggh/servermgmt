class ServerOperationSystem < ActiveRecord::Base
  default_scope :order => :name
	has_many :servers
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
