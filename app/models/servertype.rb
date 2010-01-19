class Servertype < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :server_type_hardware_id
  
  has_many :servers
  belongs_to :server_type_hardware
end
