class Ip < ActiveRecord::Base
  default_scope :order => :ip

  belongs_to :network
  belongs_to :server
  belongs_to :ip_type
  has_one :server_interface, :dependent => :destroy
  
  validates_presence_of :ip
  validates_presence_of :network_id
  validates_presence_of :ip_type
  validate :checkip
  validate :ip_in_net, :if => :checkip
  validates_uniqueness_of :ip, :if => :checkip
  validates_uniqueness_of :is_primary, :if => :checkip, :scope => [ :ip, :server_id ]

  def ip_in_net
    net = Network.find(:first, :conditions => "network >> '#{ip}'")
    if net
      true
    else
      errors.add('IP Address', 'is not in the network.')
      false
    end
  end

  def checkip
    if ServerManager.new.is_ipaddress(ip)
      return true
    else
      if errors.count < 1
        errors.add('IP Address')
      end
      return false
    end
  end

end
