class DomainOption < ActiveRecord::Base
  has_many :domain_option_values
  has_many :domains, :through => :domain_option_values

  validates_presence_of :name
  validates_uniqueness_of :name

  default_scope :order => 'name ASC'
end
