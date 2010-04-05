class Host < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_puppet"
  has_many :fact_values, :dependent => :destroy
  has_many :fact_names, :through => :fact_values
  has_many :resources, :include => :param_values, :dependent => :destroy

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

  def getFactValue(fact)
    values = Array.new
    if fv = self.fact_values.find(:all, :include => :fact_name,
                                     :conditions => "fact_names.name = '#{fact}'")
      values = fv[0].value.split(',') if fv[0]
    end
    if fact == "vlans"
      values.sort!{|x,y| x.to_i <=> y.to_i }
    end
    values
  end

  def getInterfaces
    getFactValue('interfaces')
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

  def get_smserver
    hostname = name.split(/\./, 2)
    server = Server.find(:first, :include => :domain, :conditions => "servers.name = '#{hostname[0]}' AND domains.name = '#{hostname[1]}'")
    if server
      return server
    end
    nil
  end

end
