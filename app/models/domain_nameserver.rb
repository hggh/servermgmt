class DomainNameserver < ActiveRecord::Base
  validates_presence_of :nameserver_id
  validates_presence_of :domain_id
  validates_format_of :primary_ns, :with => /^(true|false)$/

  after_update :update_domain_serial
  before_destroy :update_domain_serial
  
  #FIXME: check here, one domain can only have one primary name server
  
  belongs_to :nameserver
  belongs_to :domain

  def nstype
    if "#{primary_ns}" == "true"
      "master"
    else
      "slave"
    end
  end

  def dnszonestorefilename
    File.join(Setting.get('dns_zone_files_store_path'),nstype,domain.name)
  end

  def update_domain_serial
    @domains = Domain.find(:all, :include => [ "domain_nameservers" ], :conditions => "domain_nameservers.id=#{id}")
    @domains.each do |dd|
      dd.touch
    end
  end
end
