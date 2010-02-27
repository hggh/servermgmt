class Nameserver < ActiveRecord::Base
  validates_presence_of :ip
  validates_presence_of :name
  validate :checkip
  
  has_many :domain_nameservers
  
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
