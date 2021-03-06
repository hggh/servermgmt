class Domain < ActiveRecord::Base
  require 'idn'
  include IDN

  default_scope :order => :name

  has_many :domain_records, :dependent => :destroy
  has_many :domain_nameservers, :dependent => :destroy
  has_many :domain_option_values, :dependent => :destroy
  has_many :domain_options, :through => :domain_option_values
  has_one :domain_soa, :dependent => :destroy
  has_many :servers, :order => 'name ASC'


  before_save :make_lowercase, :bump_serial

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_length_of :name, :minimum => 3
  
  def to_param
     "#{id}"
  end

  def DomainIsIdn
    if self.name != Idna.toASCII(self.name)
      return true
    end
    false
  end

  def getMaster
    DomainNameserver.find(:first, :conditions => "domain_id = #{id} AND primary_ns = 'true'")
  end

  def hasSOA?
    # return false if domain has got an master but no SOA record
    if getMaster
      if domain_soa == nil
        return false
      end
    end
    return true
  end

  def isReverseZone
    if (name =~ /(\.ip6\.arpa|\.in-addr\.arpa)$/)
      return true
    end
    false
  end

  def self.getAllwithoutRDNS
    Domain.find(:all, :conditions => "name NOT LIKE '%.ip6.arpa' AND name NOT LIKE '%.in-addr.arpa'")
  end

  def idn
    Idna.toASCII(self.name)
  end

  def bump!
    self.save
  end

  def self.withServers
    Domain.where(:id => Server.select(:domain_id).group(:domain_id).map{|d| d.domain_id})
  end

  private
    def make_lowercase
      self.name.downcase!
    end

    def bump_serial
      serial_cur = self.serial
      if serial_cur != nil
        if serial_cur.to_s.length == 10
          date = serial_cur.to_s[0,8]
          serialt = serial_cur.to_s[8,9].to_i
          if getSerialTime.to_s == date
            serialt += 1
            if serialt.to_s.length == 1
              serialt = "0" + serialt.to_s
            end
            serial_new = date + serialt.to_s
          else
            # cur date != date from DB we change all
            serial_new = getSerialTime + "01"
          end
        else
          # String is not conform
          serial_new = getSerialTime + "01"
        end
      else
        serial_new = getSerialTime + "01"
      end

      self.serial = serial_new
    end

    def getSerialTime
      time = Time.new
      time.strftime("%Y%m%d")
    end
end
