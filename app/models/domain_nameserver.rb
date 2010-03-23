class DomainNameserver < ActiveRecord::Base
  validates_presence_of :nameserver_id
  validates_presence_of :domain_id
  validates_format_of :primary_ns, :with => /^(true|false)$/
  validates_uniqueness_of :nameserver_id, :scope => :domain_id
  validate :check_nameserver

  before_save :add_soa_record
  after_update :update_domain_serial
  before_destroy :update_domain_serial
  
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
    File.join(Setting.get('dns_zone_files_store_path'),nstype,domain.idn)
  end

  def check_nameserver
    where_cond  = "domain_id=#{domain_id} AND primary_ns=true"
    where_cond += " AND id!=#{id}" if !new_record?
    master_ns = DomainNameserver.find(:all, :conditions => where_cond)
    if master_ns and master_ns.count  > 0 and primary_ns == true
      errors.add('Nameserver','problem. One Domain could have only one primary nameserver.')
    end
  end

  def add_soa_record
    if new_record? and primary_ns == true
      # add an SOA record if user adds an master NS, and domain has got no SOA
        soa = DomainSoa.find_by_domain_id(domain_id)
        if !soa and errors.count == 0
          domain_soa = DomainSoa.new()
          domain_soa.domain_id = domain_id
          domain_soa.primary_ns = nameserver.name
          domain_soa.mail = 'root@' + domain.idn
          domain_soa.save
        end
    end
  end

  def update_domain_serial
    @domains = Domain.find(:all, :include => [ "domain_nameservers" ], :conditions => "domain_nameservers.id=#{id}")
    @domains.each do |dd|
      dd.touch
    end
  end
end
