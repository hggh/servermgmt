class Nameserver < ActiveRecord::Base
  default_scope :order => :name

  validates_presence_of :ip
  validates_presence_of :name
  validate :checkip
  
  has_many :domain_nameservers, :dependent => :destroy

  # FIXME: If user change the record, we have to trigger an update to all domains, that using this NS
  
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
