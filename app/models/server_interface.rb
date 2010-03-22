class ServerInterface < ActiveRecord::Base
  validates_presence_of :server_id
  validates_presence_of :interface_id
  validates_presence_of :vlan_id
  validates_presence_of :ip_id
  validates_format_of :default_gw, :with => /^(true|false)$/
  validates_format_of :alias, :with => /^(true|false)$/
  validates_uniqueness_of :ip_id, :scope => [:server_id, :interface_id]

  belongs_to :server
  belongs_to :vlan
  belongs_to :interface
  belongs_to :ip
  has_many :server_interface_options, :dependent => :destroy
  has_many :interface_options, :through => :server_interface_options

end
