class ServerInterface < ActiveRecord::Base
  validates_presence_of :server_id
  validates_presence_of :interface_id
  validates_presence_of :vlan_id
  validates_presence_of :ip_id
  validates_presence_of :alias
  validates_presence_of :default_gw

  belongs_to :server
  belongs_to :vlan
  belongs_to :interface
  belongs_to :ip
  has_many :server_interface_options, :dependent => :destroy
  has_many :interface_options, :through => :server_interface_options

end
