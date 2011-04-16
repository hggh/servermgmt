require 'rexml/document'
require 'net/http'

module Puppet::Parser::Functions
  newfunction(:ssh_public_keys, :type => :rvalue) do |args|
    hashindex = args[0]

    servermgmt_host = lookupvar('servermgmt_host')
    servermgmt_secret = lookupvar('servermgmt_secret')
    fqdn = lookupvar('fqdn')
    sshkeys = Hash.new
    
    begin
    
    uri = URI.parse(servermgmt_host + fqdn + '?secret=' + servermgmt_secret)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    request["Content-Type"] = "text/xml"

    response = http.request(request)

    if response
      xml = REXML::Document.new(response.body)
      xml.elements.each("//username") { |element|
        username = element.attributes['name']
        username_keys = Array.new
        element.elements.each("key") { |key|
          username_keys << key.text
        }

        sshkeys[username] = username_keys.join("\n")
      }
      if hashindex
        return sshkeys.keys
      else
        sshkeys
      end

    end
    
    rescue
      raise Puppet::ParseError, "Could not connect to Server Manager"
    end
    

  end
end
