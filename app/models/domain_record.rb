class DomainRecord < ActiveRecord::Base
  validates_presence_of :ttl
  validates_presence_of :domain_record_type_id
  validates_presence_of :domain_id
  validate :check_value_record
  validates_numericality_of :ttl

	belongs_to :domain
  belongs_to :domain_record_type

  before_destroy :update_serial
  after_save :update_serial
  before_validation :make_lowercase

  def value=(content)
    clean = content
    # RecordType is PTR and no dot on end, we will add one
    if domain_record_type.name == 'PTR' and content !~ /\.$/ and content.length > 0
      clean = content + '.'
    end
    # RecordType is NS and no dot on end, we will add one
    if domain_record_type.name == 'NS' and content !~ /\.$/
      clean = content + '.'
    end
    # RecordType is MX and no dot on end, we will add one
    if domain_record_type.name == 'MX' and content !~ /\.$/
      clean = content + '.'
    end
    write_attribute(:value, clean)
  end
  private
  def update_serial
    domain = Domain.find(domain_id)
    domain.touch
  end

  def make_lowercase
    self.source.downcase!
    self.value.downcase!
  end

  def check_value_record
    if value.length == 0
      errors.add('content', 'Could not be empty.')
      return false
    end
    if domain_record_type.name == 'PTR'
      if source !~ /^[0-9]+$/ or !source
        errors.add('Type', ' is PTR, Name sould be an integer.')
      end
      if value.length == 0 or value !~ /^[A-Za-z0-9\-_\.]+$/
        errors.add('content', 'bad charactor for content')
      end
    end
    if domain_record_type.name == 'A'
      if ServerManager.new.is_ipv4?(value) == false
        errors.add('content', 'is not an valid IPv4 address')
      end
    end
    if domain_record_type.name == 'AAAA'
      if ServerManager.new.is_ipv6?(value) == false
        errors.add('content', 'is not an valid IPv6 address')
      end
    end
    if domain_record_type.name == 'MX'
      if extra_value !~ /^[0-9]+$/ or !extra_value
        errors.add('MX', ' records needs an Prio.')
      end
    end
  end

end
