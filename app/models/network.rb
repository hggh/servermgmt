class Network < ActiveRecord::Base
  default_scope :order => :network

  validate :check_network
  validates_presence_of :comment
  validates_length_of :comment, :minimum => 4


  validates_uniqueness_of :network, :if => :check_network
  #FIXME: We should check if Gateway is in the network range!


  has_many :ips, :dependent => :destroy

  def hostmask
    @hostmask = Network.find_by_sql("SELECT hostmask(network) AS hostmask FROM networks WHERE id=#{id}")
    return @hostmask[0]['hostmask']
  end

  def netmask
    @netmask = Network.find_by_sql("SELECT netmask(network) AS netmask FROM networks WHERE id=#{id}")
    return @netmask[0]['netmask']
  end

  def broadcast
    @broadcast = Network.find_by_sql("SELECT host(broadcast(network)) AS broadcast FROM networks WHERE id=#{id}")
    return @broadcast[0]['broadcast']
  end

  def size
    IPAddr.new(broadcast()).to_i - IPAddr.new(network).to_i + 1
  end

  def ipversion
    if IPAddr.new(network).ipv6?
      6
    else
      4
    end
  end

  def gw=(gateway)
    gw_clean = ''
    if ServerManager.new.is_ipaddress(gateway)
      gw_clean = gateway
    else
      if check_network
        ipaddr = IPAddr.new(network.split('/')[0])
        if ipaddr.ipv6?
          gw_clean = IPAddr.new(ipaddr.to_i + 1 , Socket::AF_INET6).to_s
        else
          gw_clean = IPAddr.new(ipaddr.to_i + 1 , Socket::AF_INET).to_s
        end
      end
    end
    write_attribute(:gw, gw_clean)
  end

  def check_network
    if ServerManager.new.is_network(network)
      return true
    end
    if errors.count < 1
      errors.add('Network')
    end
    false
  end

end
