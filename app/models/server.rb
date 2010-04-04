class Server < ActiveRecord::Base
  
  before_destroy [ :clean_server_virtuals, :clean_puppet ]
  before_save :make_lowercase
  
  validates_presence_of :customer_id
  validates_presence_of :name
  validates_presence_of :servertype_id
  validates_presence_of :server_operation_system_id
  validates_presence_of :domain_id
  validates_length_of :name, :minimum => 3
  validates_uniqueness_of :name, :scope => :domain_id
  validates_format_of :name, :with => /^[0-9A-Za-z\-]+$/


  
  
  
  belongs_to :customer
  belongs_to :servertype
  belongs_to :server_operation_system
  belongs_to :domain
  
  has_many :ips, :dependent => :destroy
  has_many :server_macs, :dependent => :destroy
  has_many :configkey_values, :dependent => :destroy
  has_many :server_group_members, :dependent => :destroy
  has_many :server_interfaces, :dependent => :destroy
  
  def self.getFreeVirtualServers
    servers_free = Server.find(:all, :joins => " LEFT JOIN servertypes ON servertypes.id = servers.servertype_id LEFT JOIN server_virtuals ON server_virtuals.virtual_id = servers.id " , :conditions => "servertypes.server_type_hardware_id = 2 AND server_virtuals.virtual_id IS NULL")
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
