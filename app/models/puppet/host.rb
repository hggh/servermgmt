class Puppet::Host < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  has_many :fact_values, :dependent => :destroy
  has_many :fact_names, :through => :fact_values
  def fact(name)
    if fv = self.fact_values.find(:all, :include => :fact_name,
                                      :conditions => "fact_names.name = '#{name}'")
      return fv
    else
      return nil
    end
  end
  
  def get_facts
    fact_values.find(:all, :include => :fact_name, :order => "fact_names.name")
    
  end
  
  def getIps
    ipaddresses = Array.new
    if fv = self.fact_values.find(:all, :include => :fact_name,
                                     :conditions => "fact_names.name = 'interfaces'")
      fv[0].value.split(',').each do |int|
        interface = "ipaddress_" + int
        fvi = self.fact_values.find(:all,:include => :fact_name, :conditions => "fact_names.name = '#{interface}'")
        if fvi[0] != nil
          ipaddresses.insert(-1,fvi[0].value )
        end
      end
    end
    ipaddresses
  end
  
end
