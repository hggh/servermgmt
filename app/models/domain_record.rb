class DomainRecord < ActiveRecord::Base
  validates_presence_of :ttl
  validates_presence_of :domain_record_type_id
  validates_presence_of :domain_id
  validates_numericality_of :ttl

	belongs_to :domain
  belongs_to :domain_record_type

  after_destroy :update_serial
  before_save :update_serial

  private
    def update_serial
      domain = Domain.find(domain_id)
      domain.touch
    end
end
