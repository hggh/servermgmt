class DomainSoa < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id
  validates_presence_of :mail
  validates_presence_of :primary_ns

  def mailaddress
    address = mail.split(/@/)
    address[0].gsub!(/\./, '\.')
    address[0] + '.' + address[1] + '.'
  end

  def initialize(params = nil)
    super
    self.ttl = Setting.get('dns_soa_ttl') unless self.ttl
    self.refresh = Setting.get('dns_soa_refresh') unless self.refresh
    self.retry = Setting.get('dns_soa_retry') unless self.retry
    self.expire = Setting.get('dns_soa_expire') unless self.expire
    self.negative_ttl = Setting.get('dns_soa_negative_ttl') unless self.negative_ttl
  end
end
