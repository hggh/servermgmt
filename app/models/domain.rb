class Domain < ActiveRecord::Base
	has_many :servers
  belongs_to :customer
  
  
  def self.DomainbyCust(customerid)
    Domain.find(:all, :conditions => "customer_id = #{customerid}")
  end
end
