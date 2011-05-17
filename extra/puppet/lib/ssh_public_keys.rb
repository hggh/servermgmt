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

      tries = 0
      begin
        uri = URI.parse(servermgmt_host + fqdn)
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({"secret" => servermgmt_secret});
      rescue
        if tries < 2 then
          tries += 1
          retry
        else
          raise "Could not build URI and Net::HTTP"
        end
      end

      tries = 0
      begin
        response = http.request(request)
      rescue
        if tries < 2 then
          tries += 1
          retry
        else
          raise "Could not connect to host"
        end
      end

      if response and response.code == '200'
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

      else
        raise "Response from ServerMGMT was: #{response.code}"
      end

    rescue Exception => e
      # FIXME: add caching of the last request and deliver caching file to puppet
      raise Puppet::ParseError, "Could not connect to Server Manager: #{e.message}"
    end


  end
end
