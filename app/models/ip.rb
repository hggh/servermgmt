class Ip < ActiveRecord::Base
  default_scope :order => :ip
  require 'ipaddr'
  def is_ipaddress
    begin
      net = IPAddr.new ip
      if net.ipv4? or net.ipv6?
        return true
      else
      end
    rescue 
      errors.add(:ip, " is not valid")
      return false
    end
  end
  
  belongs_to :network
  belongs_to :server
  belongs_to :iptype
  validates_presence_of :ip
  validate :is_ipaddress
  validates_uniqueness_of :ip, :if => :is_ipaddress
  
  
  
end
