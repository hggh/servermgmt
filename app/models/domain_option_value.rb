class DomainOptionValue < ActiveRecord::Base
  belongs_to :domain
  belongs_to :domain_option

  validates_presence_of :domain_id
  validates_presence_of :domain_option_id
  validates_presence_of :value
end
