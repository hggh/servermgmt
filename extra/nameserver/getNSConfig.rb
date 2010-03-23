#!/usr/bin/env ruby

require 'socket'
require 'net/http'
require 'uri'
require 'yaml'

configfile = ARGV[0] ? ARGV[0] : "/etc/servermgmt.yml"

if !File.readable?(configfile)
  $stderr.puts "Warning: Could not open config file: #{configfile}"
  exit 1
end

settings = YAML::load(File.open(configfile))
SERVERMGMT_HOST= settings['getnsconfig']['sm_host']
SERVERMGMT_NSSERVER= (settings['getnsconfig']['nameserver_name'] != nil) ? settings['getnsconfig']['nameserver_name'] : Socket.gethostbyname(Socket.gethostname).first
SERVERMGMT_NSTYPE=settings['getnsconfig']['nameserver_type']
SERVERMGMT_CONFIGPATH=settings['getnsconfig']['nameserver_config']

servermgmt_url = SERVERMGMT_HOST + SERVERMGMT_NSSERVER + "/" + SERVERMGMT_NSTYPE + "/"
errorcode = 0

['config', 'zone'].each do |cfg|

  begin
    Net::HTTP.start( URI.parse(servermgmt_url).host.to_s, URI.parse(servermgmt_url).port ) { |http|

      req = Net::HTTP::Get.new(URI.parse(servermgmt_url).path + cfg)
      # req.basic_auth 'user', 'pass'
      reponse = http.request(req)
      if reponse and  File.writable?(SERVERMGMT_CONFIGPATH) and cfg == 'config'
        nsconfig = File.new(SERVERMGMT_CONFIGPATH + '.new', 'w')
        nsconfig.puts reponse.body
        nsconfig.close
        cmdout = `/usr/sbin/named-checkconf #{SERVERMGMT_CONFIGPATH + '.new'}`
        if $? != 0
          $stderr.puts "#{SERVERMGMT_CONFIGPATH} has got an error: #{cmdout}"
          File.unlink(SERVERMGMT_CONFIGPATH + '.new')
          errorcode = 1
        else
          File.rename(SERVERMGMT_CONFIGPATH + '.new',SERVERMGMT_CONFIGPATH)
        end

      end

      if reponse and cfg == 'zone'
        zones = reponse.body.to_s.split(/^; ----- SPLIT -------\n/)
        zones.each do |zz|
          next if zz.to_s.length == 0 or zz.to_s =~ /^; Nameserver Name:/
          filename =  /^; Zone-BEGIN: (.*)\n/.match(zz.to_s)[1]
          if File.writable?(File.dirname(filename))
            nszone = File.new(filename + '.new', 'w')
            nszone.puts zz.to_s
            nszone.close
            cmdout = `/usr/sbin/named-checkzone #{File.basename(filename)} #{filename + '.new'}`
            if $? != 0
              $stderr.puts "#{filename} has got an error: #{cmdout}"
              File.unlink(filename + '.new')
              errorcode = 1
            else
              File.rename(filename + '.new',filename)
            end
          end
        end
      end
    }
  rescue
    $stderr.puts "Could not connect to #{URI.parse(servermgmt_url).host.to_s}:#{URI.parse(servermgmt_url).port}"
    exit 1
  end
end

if errorcode == 0
  # OK, reload bind
  `/usr/sbin/rndc reload`
else
  exit 1
end
