class DomainRecord < ActiveRecord::Base
  validates_presence_of :ttl
  validates_presence_of :value
  validates_presence_of :domain_record_type_id
  validates_presence_of :domain_id
  validates_numericality_of :ttl

	belongs_to :domain
  belongs_to :domain_record_type

  before_destroy :update_serial
  after_save :update_serial

  def value=(content)
    clean = content
    # RecordType is PTR and no dot on end, we will add one
    if domain_record_type_id == 11 and content !~ /\.$/
      clean = content + '.'
    end
    # RecordType is NS and no dot on end, we will add one
    if domain_record_type_id == 9 and content !~ /\.$/
      clean = content + '.'
    end
    # RecordType is MX and no dot on end, we will add one
    if domain_record_type_id == 7 and content !~ /\.$/
      clean = content + '.'
    end
    write_attribute(:value, clean)
  end
  private
    def update_serial
      domain = Domain.find(domain_id)
      domain.touch
    end
end
