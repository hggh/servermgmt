class DomainOptionValue < ActiveRecord::Base
  belongs_to :domain
  belongs_to :domain_option

  validates_presence_of :domain_id
  validates_presence_of :domain_option_id
  validate :check_value
  validates_uniqueness_of :value, :scope => [:domain_id, :domain_option_id]

  before_destroy :update_serial
  after_save :update_serial

  private
  def check_value
    if defined?value and value != ""
      if domain_option.name == "allow-transfer" or domain_option.name == "allow-notify" or domain_option.name == "allow-update"
        if ! ServerManager.new.is_ipaddress(value)
          errors.add('Value', "should be an valid IPv4/IPv6 address.")
        end
      end
    else
      errors.add('Value', "can't be blank.")
    end
  end

  def update_serial
    domain = Domain.find(domain_id)
    domain.bump!
  end
end
