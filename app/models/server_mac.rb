class ServerMac < ActiveRecord::Base
  validates_presence_of :mac
  validates_length_of :mac, :is => 17
  validates_uniqueness_of :mac

  belongs_to :server
end
