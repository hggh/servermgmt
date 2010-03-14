class ServerInterfaceOption < ActiveRecord::Base
  validates_presence_of :value
  validates_presence_of :interface_option_id
  validates_presence_of :server_interface_id

  belongs_to :server_interface
  belongs_to :interface_option
end
