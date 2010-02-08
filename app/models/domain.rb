class Domain < ActiveRecord::Base
  require 'idn'
  include IDN
  
  has_many :servers
  has_many :domain_records
  belongs_to :customer
  
  before_save :make_lowercase
  
  validates_presence_of :customer_id
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 3
  
  def DomainIsIdn
    if self.name != Idna.toASCII(self.name)
      return true
    end
    false
  end
  
  def idn
    Idna.toASCII(self.name)
  end
  
  def self.DomainbyCust(customerid)
    Domain.find(:all, :conditions => "customer_id = #{customerid}")
  end
  private
    def make_lowercase
      self.name.downcase!
    end
end
