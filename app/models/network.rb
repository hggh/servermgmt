class Network < ActiveRecord::Base
  default_scope :order => :network
  
	validate :check_network
	validates_presence_of :comment
	validates_length_of :comment, :minimum => 4
  validates_presence_of :customer
  
  validates_uniqueness_of :network, :scope => :customer_id, :if => :check_network
  #FIXME: We should check if Gateway is in the network range!
  
  belongs_to :customer
	has_many :ips, :dependent => :destroy
  
  def self.NetworkbyCust(customerid)
    Network.find(:all, :conditions => "customer_id = #{customerid}")
  end


  def gw=(gateway)
    gw_clean = ''
    if ServerManager.new.is_ipaddress(gateway)
      gw_clean = gateway
    else
      if check_network
        ipaddr = IPAddr.new(network.split('/')[0])
        gw_clean = IPAddr.new(ipaddr.to_i + 1 , Socket::AF_INET).to_s
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
