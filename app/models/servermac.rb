class Servermac < ActiveRecord::Base
  validates_presence_of :mac
  validates_length_of :mac, :is => 17
  validates_uniqueness_of :mac

	has_one :server
end
