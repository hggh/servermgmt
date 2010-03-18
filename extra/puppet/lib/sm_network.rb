# Puppet Server Manager Plugin to create etc/network/interfaces
#
require 'pg'
require 'erb'
DEBIAN_NET_LOOPBACK = <<EOF
auto lo
iface lo inet loopback

EOF
DEBIAN_NET_INTERFACES = <<EOF
# Interface Id: <%= intnr %>
auto <%= intname %>
iface <%= intname %> <% if iptype == '6' %>inet6<% else %>inet<% end %> static
	address <%= int_address %>
	netmask <%= int_netmask %><% if int_default_gw %>
	gateway <%= int_gateway %><% end %>
	<% if  iptype == '4' %>broadcast <%= int_broadcast %><% end %>
	

EOF
 
module Puppet::Parser::Functions
  newfunction(:sm_network, :type => :rvalue) do |args|
    
    pg_host = lookupvar('dblook_host')
    pg_user = lookupvar('dblook_user')
    pg_pass = lookupvar('dblook_pass')
    pg_db   = lookupvar('dblook_db')
    fqdn = lookupvar('fqdn')
    hostname = fqdn.split('.',2)
    network_interfaces = DEBIAN_NET_LOOPBACK
    
    begin
      conn = PGconn.connect(pg_host, 5432, '', '', pg_db, pg_user, pg_pass)
    rescue
      raise Puppet::ParseError, "sm_network: Could not connect to database"
    end
    
    res = conn.exec("SELECT servers.id FROM servers LEFT JOIN domains ON domains.id =
                    servers.domain_id WHERE 
                    domains.name = '#{hostname[1]}' AND 
                    servers.name = '#{hostname[0]}' LIMIT 1")
    hostid = nil
    if res.count != 1
      raise Puppet::ParseError, "sm_network: Could not find host #{fqdn} at database"
    else
      res.each do |row|
        hostid = row['id']
      end
      
    end
    
    res = conn.exec("SELECT si.*, i.name AS intname ,v.name AS vlan ,ips.ip,network(n.network) AS nw,
				netmask(n.network) AS net_nm, 
				family(n.network) AS ipfam,
				n.gw AS net_gw,
				masklen(n.network) AS net_masklen,
				broadcast(n.network) AS net_br  
			FROM server_interfaces AS si 
			LEFT JOIN interfaces AS i ON i.id = si.interface_id 
			LEFT JOIN vlans AS v ON v.id = si.vlan_id 
			LEFT JOIN ips  ON ips.id = si.ip_id 
			LEFT JOIN networks AS n ON n.id = ips.network_id 
				WHERE si.server_id=#{hostid}")
    if res.count > 0
      intipv6 = Hash.new
      intnum = 1
      res.each do |row|
        intnr = row['id']
        iptype = row['ipfam']
        int_address = row['ip']
        int_netmask = row['ipfam'] == '4' ? row['net_nm'] : row['net_masklen'] 
        int_default_gw = row['default_gw'] == 't' ? true : false
        int_gateway = row['net_gw']
        int_broadcast = row['net_br'].gsub(/\/.*/, '')
        
        intname = ''
        if row['vlan'] == 'nativ'
          intname = row['intname']
        else
          intname = row['intname'] + '.' + row['vlan']
        end
        if row['alias'] == 't' and row['ipfam'] == '4'
          intname= intname + ":" + intnum.to_s
        end
        # etc/network/interfaces can't handle eth0:2 for inet6
        if row['ipfam'] == '4'
          inttext = ERB.new(DEBIAN_NET_INTERFACES)
          network_interfaces = network_interfaces + "\n" + inttext.result(binding)
          intnum = intnum +1 if row['alias'] == 't'
        else
          # We can't handle IPv6 yet
        end
      end
      
    else
      raise Puppet::ParseError, "sm_network: Could not find Interfaces for #{fqdn} at database"
    end
    
    network_interfaces
    
    
  end
end
