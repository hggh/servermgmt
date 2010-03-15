#!/usr/bin/env ruby

require 'socket'
require 'net/http'
require 'uri'

SERVERMGMT_HOST="http://localhost:3000/nameserver/getconfig/"
SERVERMGMT_NSSERVER=Socket.gethostbyname(Socket.gethostname).first
SERVERMGMT_NSTYPE='bind'
SERVERMGMT_CONFIGPATH="/etc/bind/servermgmt.conf"

servermgmt_url = SERVERMGMT_HOST + SERVERMGMT_NSSERVER + "/" + SERVERMGMT_NSTYPE + "/"


['config', 'zone'].each do |cfg|

	Net::HTTP.start( URI.parse(servermgmt_url).host.to_s, URI.parse(servermgmt_url).port ) { |http|

		req = Net::HTTP::Get.new(URI.parse(servermgmt_url).path + cfg)
		# req.basic_auth 'user', 'pass'
		reponse = http.request(req)
		if reponse and  File.writable?(SERVERMGMT_CONFIGPATH) and cfg == 'config'
			nsconfig = File.new(SERVERMGMT_CONFIGPATH, 'w')
			nsconfig.puts reponse.body
			nsconfig.close
		end

		if reponse and cfg == 'zone'
			zones = reponse.body.to_s.split(/^; ----- SPLIT -------\n/)
			zones.each do |zz|
				next if zz.to_s.length == 0 or zz.to_s =~ /^; Nameserver Name:/
				filename =  /^; Zone-BEGIN: (.*)\n/.match(zz.to_s)[1]
				if File.writable?(File.dirname(filename))
					nszone = File.new(filename, 'w')
					nszone.puts zz.to_s
					nszone.close
				end
			end
		end
	}
end
