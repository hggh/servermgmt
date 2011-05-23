
class ssh::directories {
	file { "$ssh_keys_public_store_path":
		ensure => directory,
		mode => 755,
		owner => root,
		group => root,
		force => true,
		purge => true,
		recurse => true
	}
}


define ssh::store_ssh_public_keys ($sshkeys) {
        notice("SSH User: $name")
        file { "${ssh_keys_public_store_path}/${name}":
                mode => 644,
                owner => root,
                group => root,
                content => "${sshkeys[$name]}\n",
		require => Class['ssh::directories']

        }
}

class ssh::publickeys {
	$sshkeys_index = ssh_public_keys(true)
	$sshkeys = ssh_public_keys()

	ssh::store_ssh_public_keys { $sshkeys_index: sshkeys => $sshkeys}
}



class ssh {
	$ssh_keys_public_store_path = "/etc/ssh/keys"
	$servermgmt_host = "http://localhost:3000/puppetsshkeys/"
	$servermgmt_secret = "foo"
  # puppet:puppet 640
  $servermgmt_cache_path = "/var/lib/puppet/ssh_keys_cache"


	include ssh::directories, ssh::publickeys
}
