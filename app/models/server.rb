class Server < ActiveRecord::Base
  

  before_destroy :clean_server_virtuals
  before_destroy :clean_puppet
  before_save :make_lowercase

  validates_presence_of :name
  validates_presence_of :servertype_id
  validates_presence_of :server_operation_system_id
  validates_presence_of :domain_id
  validates_length_of :name, :minimum => 3
  validates_uniqueness_of :name, :scope => :domain_id
  validates_format_of :name, :with => /^[0-9A-Za-z\-]+$/


  belongs_to :servertype
  belongs_to :server_operation_system
  belongs_to :domain
  
  has_many :ips, :dependent => :destroy
  has_many :server_macs, :dependent => :destroy
  has_many :configkey_values, :dependent => :destroy
  has_many :server_group_members, :dependent => :destroy
  has_many :server_interfaces, :dependent => :destroy
  has_many :server_key_values, :dependent => :destroy
  has_many :server_keys, :through => :server_key_values
  has_many :sshusers, :dependent => :destroy
  
  def self.getFreeVirtualServers
    servers_free = Server.where(:servertype_id => Setting.get('server_type_hardware')).joins("LEFT JOIN server_virtuals AS sv ON sv.virtual_id = servers.id").where("sv.virtual_id IS NULL")
  end

  def self.find_by_fqdn(sfqdn)
    host,dns = sfqdn.split(/\./, 2)
    s = Server.includes(:domain).where('servers.name = ?', host).where('domains.name = ?', dns)
    s[0]
  end

  def self.allbyFqdn
    Server.order('domains.name ASC, servers.name ASC').includes(:domain)
  end

  def getServerGroupIds
    groups = Array.new
    server_group_members.each do |s|
      groups  << s.server_group_id
    end
    groups
  end

  def fqdn
  	"#{name}.#{domain.name}"
  end
 
  def getVirtualServers
    ServerVirtual.find(:all, :conditions => "hardware_id = #{id}")
  end

  def getfreeIps(ipid = nil)
    sql_where = "server_interfaces.id IS NULL"
    sql_where = "(server_interfaces.id IS NULL OR ips.id=#{ipid} )" if ipid
    Ip.find(:all, :include => :server_interface, :conditions => "ips.server_id=#{id} and #{sql_where}")
  end

  def getPuppet
    hostid = Host.find(:first, :conditions => "name = '#{fqdn}'")
    if hostid and Setting.get('puppet') == "true"
      return hostid
    end
    nil
  end
  
  def listIPsNotDocumented
    ips_not_found = Array.new
    if Setting.get('puppet') == "true" and getPuppet
      getPuppet.getIps.each do |ip|
        sip = Ip.find(:all, :conditions => "server_id = #{id} AND ip = '#{ip}'")
        if sip.count == 0
          ips_not_found.insert(-1,ip)
        end
      end
    end
    ips_not_found
  end
  
  private
    def clean_server_virtuals
      @server_virts_hw = ServerVirtual.find(:all, :conditions => "hardware_id = #{id} OR virtual_id = #{id}")
      @server_virts_hw.each do |s|
        s.destroy  
      end
    end

    def clean_puppet
      if Setting.get('puppet') == "true" and getPuppet
        getPuppet.destroy
      end
    end

    def make_lowercase
      self.name.downcase!
    end
end
