# Puppet External Data Sources 
#
require 'pg'
 
module Puppet::Parser::Functions
    newfunction(:dblookup, :type => :rvalue) do |args|
	key = args[0]
	value = Array.new

        pg_host = lookupvar('dblook_host')
        pg_user = lookupvar('dblook_user')
        pg_pass = lookupvar('dblook_pass')
        pg_db   = lookupvar('dblook_db')
        fqdn = lookupvar('fqdn')
        hostname = fqdn.split('.',2)

	begin
	        conn = PGconn.connect(pg_host, 5432, '', '', pg_db, pg_user, pg_pass)
	rescue
		raise Puppet::ParseError, "dblookup: Could not connect to database"
	end

	res = conn.exec("SELECT servers.id FROM servers LEFT JOIN domains ON domains.id =
                    servers.domain_id WHERE 
                    domains.name = '#{hostname[1]}' AND 
                    servers.name = '#{hostname[0]}' LIMIT 1 ")
	hostid = nil
	if res.count != 1
		raise Puppet::ParseError, "dblookup: Could not find host #{fqdn} at database"
	else
		res.each do |row|
			hostid = row['id']
		end
		
	end

	configkeyid = nil
	res = conn.exec("SELECT id FROM configkeys WHERE name='#{key}'")
	if res.count != 1
		raise Puppet::ParseError, "dblookup: Could not find Puppet Cfg Key (#{key}) at database"
	else
		res.each do |row|
			configkeyid = row['id']
		end
	end

	# Get the Server Groups for that Server
	server_groups = Array.new
	res = conn.exec("SELECT server_group_id FROM server_group_members WHERE server_id='#{hostid}'")
	res.each do |row|
		server_groups.insert(-1, row['server_group_id'])
	end

	server_groups.each do |group|
		res_grp = conn.exec("SELECT configkey_values.value FROM configkey_values WHERE
				server_group_id=#{group} AND configkey_id=#{configkeyid}")
		found = 0
		res_grp.each do |grow|
			if grow['value']
				found = 1
				grow['value'].split(/,/).each do |s|
					value.insert(-1,s)
				end
			end
		end
		# FIXME: Exit after first found group key. perhaps later, we want to combine it
		break if found == 1
	end

	res_srv = conn.exec("SELECT configkey_values.value FROM configkey_values WHERE
				server_id=#{hostid} AND configkey_id=#{configkeyid}")
	if res_srv.count == 1
		# OK Server has got an entry, we don't want to use the Group value
		value.clear
		res_srv.each do |vrow|
			vrow['value'].split(/,/).each do |s|
				value.insert(-1,s)
			end
		end
	end

	if value.count == 0
		# OK Server has got no group and no own entry, pick up default
		res = conn.exec("SELECT * FROM configkeys 
				WHERE name = '#{key}' LIMIT 1")
		if res.count == 1
			res.each do | vrow|
				vrow['default'].split(/,/).each do |s|
					value.insert(-1,s)
				end
			end
		end
	end

	if value.count == 0
		# For Puppet, if only one value in array, don't return as array to puppet
		value[0]
	else
		value
	end

    end
end

