class DomainNameservers < ActiveRecord::Base
  validates_presence_of :nameserver_id
  validates_presence_of :domain_id
  validates_presence_of :primary_ns
  
  #FIXME: check here, one domain can only have one primary name server
  
  belongs_to :nameserver
  belongs_to :domain
end
