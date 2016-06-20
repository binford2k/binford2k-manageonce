# Definition: manageonce::file
#
# This definition allows you to manage a file one time only.
#
# Parameters:
# All parameters are as for the file type.
#
# Sample Usage:
#  manageonce::file { '/root/.bashrc':
#    owner   => 'root',
#    group   => 'root,
#    mode    => '0644,
#    content => file('mymod/bashrc'),
#  }
#
define manageonce::file (
  $ensure                  = 'file',
  $backup                  = undef,
  $checksum                = undef,
  $content                 = undef,
  $force                   = undef,
  $group                   = undef,
  $owner                   = undef,
  $mode                    = undef,
  $path                    = $title,
  $replace                 = undef,
  $selinux_ignore_defaults = undef,
  $selrange                = undef,
  $selrole                 = undef,
  $seltype                 = undef,
  $seluser                 = undef,
  $onlyonce                = undef,
) {
  $params =  {
    ensure                  => $ensure,
    path                    => $path,
    backup                  => $backup,
    checksum                => $checksum,
    content                 => $content,
    force                   => $force,
    group                   => $group,
    mode                    => $mode,
    owner                   => $owner,
    replace                 => $replace,
    selinux_ignore_defaults => $selinux_ignore_defaults,
    selrange                => $selrange,
    selrole                 => $selrole,
    seltype                 => $seltype,
    seluser                 => $seluser,
  }

  manageonce { "manageonce: File[${title}]":
    resourcetype  => 'file',
    resourcetitle => $path,
    parameters    => $params,
    onlyonce      => $onlyonce,
  }

}
