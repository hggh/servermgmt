class Server < ActiveRecord::Base
  default_scope :order => :name
  
  validates_presence_of :customer_id
  validates_presence_of :name
  validates_presence_of :servertype_id
  validates_presence_of :serveroperationsystem_id
  validates_length_of :name, :minimum => 5
  
  belongs_to :customer
  belongs_to :servertype
  belongs_to :serveroperationsystem
  
  has_many :ips, :dependent => :destroy
  has_many :servermacs, :dependent => :destroy
  has_one :server_domain
end
