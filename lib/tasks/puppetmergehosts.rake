
desc 'Puppet Hosts migration script'

require 'active_record'

namespace :servermgmt do
  task :puppetmergehosts => :environment do
    sm_customerDB = Customer.find(:first)
    raise "Could not find any customer at Server Manager. Frist add one customer!" unless sm_customerDB
    customerId = sm_customerDB.id
    sm_ostypeDB = ServerOperationSystem.find(:first)
    raise "Could not find any Server Operation System at Server Manager. First add one OS!" unless sm_ostypeDB
    ostype_default = sm_ostypeDB.id
    sm_servertypeDB = Servertype.find(:first)
    raise "Could not find any Server Type at Server Manager. First add one Server Type!" unless sm_servertypeDB 
    servertype_default = sm_servertypeDB.id
    pp_hosts = Puppet::Host.find(:all)
    pp_hosts.each do |pp_host|
      fqdn = pp_host.name.to_s.split(/\./,2)
      sm_host = Server.find(:first, :include => :domain, :conditions => [ " domains.name=? AND servers.name=?", fqdn[1], fqdn[0] ])
      if sm_host == nil
        puts "Found: #{fqdn[0]} on #{fqdn[1]}"
        sm_domain_id = nil
        if @domain = Domain.find_by_name(fqdn[1])
          sm_domain_id = @domain.id
        else
          @domain = Domain.new(:customer_id => customerId, :name => fqdn[1])
          @domain.save
          sm_domain_id = @domain.id
        end
        sm_ostype = nil
        if @ostype = pp_host.getFactValue('lsbmajdistrelease')
          case @ostype.to_s
            when "5"
            pp_os = ServerOperationSystem.find_by_name("Debian Lenny")
            sm_ostype = pp_os.id
            when "4"
            pp_os = ServerOperationSystem.find_by_name("Debian Etch")
            sm_ostype = pp_os.id
          end
        end
        # fall back
        sm_ostype = ostype_default unless sm_ostype
        
        sm_servertype = nil
        if @servertype = pp_host.getFactValue('virtual')
          case @servertype.to_s
          when "physical"
            pp_type = Servertype.find(:first, :include => :server_type_hardware, :conditions => [ "server_type_hardwares.name='Hardware'", ])
            if pp_type
              sm_servertype = pp_type.id
            end
          when "xen0"
            pp_type = Servertype.find(:first, :include => :server_type_hardware, :conditions => [ "server_type_hardwares.name='Domain0'", ])
            if pp_type
              sm_servertype = pp_type.id
            end
          when "xenu"
            pp_type = Servertype.find(:first, :include => :server_type_hardware, :conditions => [ "server_type_hardwares.name='Virtual'", ])
            if pp_type
              sm_servertype = pp_type.id
            end            
          end
        end
        # fall back
        sm_servertype = servertype_default unless sm_servertype

        # Create Server at Database
        sm_server = Server.new(:name => fqdn[0], :domain_id => sm_domain_id, :servertype_id => sm_servertype, :server_operation_system_id => sm_ostype, :customer_id => customerId)
        if sm_server.save
          puts " Saved: #{pp_host.name}"
        else
          puts "Could not save server #{pp_host.name} at Server Manager database:"
          sm_server.errors.each do |error|
            puts "  -> " + error[0] + " " + error[1]
          end
        end
        
      else
        puts "Already at database: #{pp_host.name}"
      end
      
      
    end
  end
end
