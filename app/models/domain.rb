class Domain < ActiveRecord::Base
  has_many :servers
  has_many :domain_records
  belongs_to :customer
  
  validates_presence_of :customer_id
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 3
  
  
  def self.DomainbyCust(customerid)
    Domain.find(:all, :conditions => "customer_id = #{customerid}")
  end
end
