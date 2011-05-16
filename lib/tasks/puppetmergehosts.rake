
desc 'Puppet Hosts migration script'

require 'active_record'

namespace :servermgmt do
  task :puppetmergehosts => :environment do
    raise "Could not find any Server Operation System at Server Manager. First add one OS!" unless ServerOperationSystem.limit(1)
    raise "Could not find any Server Type at Server Manager. First add one Server Type!" unless Servertype.limit(1)
    pp_hosts = Host.all
    pp_hosts.each do |pp_host|
      fqdn = pp_host.name.to_s.split(/\./,2)
      sm_host = Server.includes(:domain).where("domains.name = ?", fqdn[1]).where("servers.name = ? ", fqdn[0]).first
      if sm_host == nil
        puts "Server not found at DB: #{fqdn[0]} on #{fqdn[1]}"
        sm_domain_id = nil
        if @domain = Domain.find_by_name(fqdn[1])
          sm_domain_id = @domain.id
        else
          @domain = Domain.new(:name => fqdn[1])
          @domain.save
          sm_domain_id = @domain.id
        end

        puppet_ostype = pp_host.getFactValue('lsbdistcodename')
        sm_os_type_default = ServerOperationSystem.where("name ILIKE ?", '%unknown%').first.id
        sm_os_type = nil
        if puppet_ostype
          sm_os = ServerOperationSystem.where("name ILIKE ?", '%' + puppet_ostype.to_s  + '%').first
          if sm_os
            sm_os_type = sm_os.id
          end
        end
        sm_os_type = sm_os_type_default unless sm_os_type

        if Servertype.where("name ILIKE ?", '%hardware%').first
          sm_server_type_hardware = Servertype.where("name ILIKE ?", '%hardware%').first.id
        else
          raise "Could not find default hardware type: %hardware%"
        end

        if Servertype.where("name ILIKE ?", '%virtual%').first
          sm_server_type_virtual = Servertype.where("name ILIKE ?", '%virtual%').first.id
        else
          raise "Could not find default virtual type: %virtual%"
        end
        sm_server_type = sm_server_type_hardware

        sm_server_type = sm_server_type_virtual if pp_host.getFactValue('is_virtual')

        server = Server.new(:name => fqdn[0], :domain_id => sm_domain_id, :servertype_id => sm_server_type, :server_operation_system_id => sm_os_type)
        if server.save
          puts "    Saved as: #{server.fqdn}"
        else
          puts "    Error at saving #{pp_host.name}"
        end
      else
        puts "Already at database: #{pp_host.name}"
      end
    end
  end
end
