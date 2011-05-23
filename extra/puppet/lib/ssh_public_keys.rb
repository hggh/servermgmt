require 'rexml/document'
require 'net/http'

module Puppet::Parser::Functions
  newfunction(:ssh_public_keys, :type => :rvalue) do |args|
    hashindex = args[0]

    servermgmt_host = lookupvar('servermgmt_host')
    servermgmt_secret = lookupvar('servermgmt_secret')
    fqdn = lookupvar('fqdn')
    sshkeys = Hash.new
    cache_path = lookupvar("servermgmt_cache_path")

    if !cache_path or !File.directory?(cache_path)
      raise Puppet::ParseError, "Please set `servermgmt_cache_path`"
    end

    def cache_save(cache_path, fqdn, content)
      begin
        File.open(File.join(cache_path, fqdn), 'w') { |f|
          f.write(content)
        }
      rescue Exception => e
        raise Puppet::ParseError, "Could not write cache data to cache at #{File.join(cache_path, fqdn)}"
      end
    end

    def cache_read(cache_path, fqdn)
      begin
        File.open(File.join(cache_path, fqdn), 'r') { |f|
          return f.read
        }
      rescue

      end
      false
    end

    def parse_xml(content)

      sshkeys = Hash.new
      xml = REXML::Document.new(content)
      xml.elements.each("//username") { |element|
        username = element.attributes['name']
        username_keys = Array.new
        element.elements.each("key") { |key|
          username_keys << key.text
        }

        sshkeys[username] = username_keys.join("\n")
      }
      sshkeys
    end


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
          cache = cache_read(cache_path, fqdn)

          if cache
            Puppet.notice "SSH public key webservice not available, used cached version"
            sshkeys = parse_xml(cache)

          else
            raise "Could not connect to host"
          end
        end
      end

      if response and response.code == '200'
        sshkeys = parse_xml(response.body)
        cache_save(cache_path, fqdn, response.body)
      else
        raise "Response from ServerMGMT was: #{response.code}"
      end

    rescue Exception => e
      cache = cache_read(cache_path, fqdn)

      if cache
        Puppet.notice "SSH public key webservice not available, used cached version"
        sshkeys = parse_xml(cache)

      else
        raise Puppet::ParseError, "Could not connect to Server Manager: #{e.message}"
      end
    end

    if hashindex
      sshkeys.keys
    else
      sshkeys
    end

  end
end
