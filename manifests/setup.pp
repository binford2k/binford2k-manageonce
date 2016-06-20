class manageonce::setup {
  $path = "${puppet_vardir}/manageonce"

  # This is where we store any scripts we'll use
  file { $path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { "${path}/record_resource.rb":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/manageonce/record_resource.rb'
  }

}
