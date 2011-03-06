class Nameserver < ActiveRecord::Base
  default_scope :order => :name

  validates_presence_of :ip
  validates_presence_of :name
  validate :checkip

  has_many :domain_nameservers, :dependent => :destroy

  after_update :update_domain_serial
  before_destroy :update_domain_serial

  def update_domain_serial
    @domains = Domain.find(:all, :include => [ "domain_nameservers" ], :conditions => "domain_nameservers.nameserver_id=#{id}")
    @domains.each do |dd|
      dd.bump!
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
