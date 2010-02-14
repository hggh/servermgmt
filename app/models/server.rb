class Server < ActiveRecord::Base
  default_scope :order => :name
  
  before_destroy :clean_server_virtuals
  before_save :make_lowercase
  
  validates_presence_of :customer_id
  validates_presence_of :name
  validates_presence_of :servertype_id
  validates_presence_of :serveroperationsystem_id
  validates_presence_of :domain_id
  validates_length_of :name, :minimum => 3
  validates_uniqueness_of :name, :scope => :domain_id
  validates_format_of :name, :with => /^[0-9A-Za-z\-]+$/


  
  
  
  belongs_to :customer
  belongs_to :servertype
  belongs_to :serveroperationsystem
  belongs_to :domain
  
  has_many :ips, :dependent => :destroy
  has_many :server_macs, :dependent => :destroy
  has_many :configkey_values, :dependent => :destroy
  has_many :server_group_members,  :dependent => :destroy
  
  def self.getFreeVirtualServers
    servers_free = Server.find(:all, :joins => " LEFT JOIN servertypes ON servertypes.id = servers.servertype_id LEFT JOIN server_virtuals ON server_virtuals.virtual_id = servers.id " , :conditions => "servertypes.server_type_hardware_id = 2 AND server_virtuals.virtual_id IS NULL")
  end

  def fqdn
  	"#{name}.#{domain.name}"
  end
 
  def getVirtualServers
    ServerVirtual.find(:all, :conditions => "hardware_id = #{id}")
  end
  
  private
    def clean_server_virtuals    
      @server_virts_hw = ServerVirtual.find(:all, :conditions => "hardware_id = #{id} OR virtual_id = #{id}")
      @server_virts_hw.each do |s|
        s.destroy  
      end
    end
    
    def make_lowercase
      self.name.downcase!
    end
end
