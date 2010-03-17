class DomainOption < ActiveRecord::Base
  has_many :domain_option_values
  has_many :domains, :through => :domain_option_values

  validates_presence_of :name
end
