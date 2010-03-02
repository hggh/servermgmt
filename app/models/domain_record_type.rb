class DomainRecordType < ActiveRecord::Base
  validates_presence_of :name

  has_many :domain_records
end
