class Servermac < ActiveRecord::Base
  validates_presence_of :mac
  validates_length_of :mac, :is => 17

	has_one :server
end
