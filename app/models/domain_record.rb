class DomainRecord < ActiveRecord::Base

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
