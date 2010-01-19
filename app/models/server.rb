class Server < ActiveRecord::Base
  default_scope :order => :name
  
  before_destroy :clean_server_virtuals
  
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
  has_many :servermacs, :dependent => :destroy
  
  
  
  private
    def clean_server_virtuals    
      @server_virts_hw = ServerVirtual.find(:all, :conditions => "hardware_id = #{id} OR virtual_id = #{id}")
      @server_virts_hw.each do |s|
        s.destroy  
      end
    end
end