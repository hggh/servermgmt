class DomainSoa < ActiveRecord::Base
  belongs_to :domain
    
  def mailaddress
    address = mail.split(/@/)
    address[0].gsub!(/\./, '\.')
    address[0] + '.' + address[1]
  end
end
