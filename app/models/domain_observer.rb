class DomainObserver < ActiveRecord::Observer
  def after_save(record)
    pid = Process.fork
    if pid.nil? then
      if Setting.get("mcollective_nameserver") == "true"
        # Frist update master, so slave gets the new records from master
        if master = record.getMaster
          call_mcollective("primary", master.nameserver.mcollective_host, record.name) if master.nameserver.mcollective_host.length > 0
          sleep(20)
        end

        record.domain_nameservers.each do |dns|
           if dns.nameserver.mcollective_host.length > 0 and dns.primary_ns == false
            call_mcollective("secondary", dns.nameserver.mcollective_host, record.name)
            sleep(5)
          end
        end
      end
    else
      Process.detach(pid)
    end
  end

  def call_mcollective(mcollective_action_suffix, host, zone)
    mcollective_cmd = Array.new
    mcollective_cmd << Setting.get("mcollective_binary")
    mcollective_cmd << " --action"
    mcollective_cmd << "servermgmt"
    mcollective_cmd << "--agent"
    mcollective_cmd << "ns_reload_" + mcollective_action_suffix
    mcollective_cmd << "--wi"
    mcollective_cmd << host
    mcollective_cmd << "--argument"
    mcollective_cmd << "zone=" + zone
    exec mcollective_cmd.join(' ')
  end
end