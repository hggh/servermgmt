class Network < ActiveRecord::Base
  default_scope :order => :network
  
	validates_format_of :network, :with => /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}$/, :on => :save
	validates_presence_of :comment
	validates_length_of :comment, :minimum => 4
  validates_presence_of :customer
  
  
  belongs_to :customer
	has_many :ips, :dependent => :destroy
  
  def self.NetworkbyCust(customerid)
    Network.find(:all, :conditions => "customer_id = #{customerid}")
  end
end
