#
class pdnsd::config inherits pdnsd
{

  File {
    owner   => 0,
    group   => 0,
    mode    => '0644',
  }

  file { '/etc/default/pdnsd':
    ensure  => file,
    content => template("${module_name}/default_pdnsd.erb"),
  }

  file { $::pdnsd::config:
    ensure  => file,
    content => template($::pdnsd::config_template),
  }

  #we need to prepend 127.0.0.1 to resolv.conf
  #this in ubuntu dhcp3 specific
  file { '/etc/dhcp/dhcpclient.conf':
    ensure => file,
    source => "puppet:///modules/${module_name}/dhcpclient.conf",
  }
}
