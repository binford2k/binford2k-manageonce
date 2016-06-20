# Definition: manageonce::file
#
# This definition allows you to manage a user one time only.
#
# Parameters:
# All parameters are as for the user type.
#
# Sample Usage:
#  manageonce::user { 'joe':
#    ensure   => present,
#    password => hiera('defaults::user::initialpassword'),
#  }
#
define manageonce::user (
  $ensure                  = undef,
  $allowdupe               = undef,
  $attribute_membership    = undef,
  $attributes              = undef,
  $auth_membership         = undef,
  $auths                   = undef,
  $comment                 = undef,
  $expiry                  = undef,
  $forcelocal              = undef,
  $gid                     = undef,
  $groups                  = undef,
  $home                    = undef,
  $ia_load_module          = undef,
  $iterations              = undef,
  $key_membership          = undef,
  $keys                    = undef,
  $loginclass              = undef,
  $managehome              = undef,
  $membership              = undef,
  $password                = undef,
  $password_max_age        = undef,
  $password_min_age        = undef,
  $profile_membership      = undef,
  $profiles                = undef,
  $project                 = undef,
  $purge_ssh_keys          = undef,
  $role_membership         = undef,
  $roles                   = undef,
  $salt                    = undef,
  $shell                   = undef,
  $system                  = undef,
  $uid                     = undef,
  $onlyonce                = undef,
) {
  $params =  {
    ensure                  => $ensure,
    allowdupe               => $allowdupe,
    attribute_membership    => $attribute_membership,
    attributes              => $attributes,
    auth_membership         => $auth_membership,
    auths                   => $auths,
    comment                 => $comment,
    expiry                  => $expiry,
    forcelocal              => $forcelocal,
    gid                     => $gid,
    groups                  => $groups,
    home                    => $home,
    ia_load_module          => $ia_load_module,
    iterations              => $iterations,
    key_membership          => $key_membership,
    keys                    => $keys,
    loginclass              => $loginclass,
    managehome              => $managehome,
    membership              => $membership,
    name                    => $name,
    password                => $password,
    password_max_age        => $password_max_age,
    password_min_age        => $password_min_age,
    profile_membership      => $profile_membership,
    profiles                => $profiles,
    project                 => $project,
    purge_ssh_keys          => $purge_ssh_keys,
    role_membership         => $role_membership,
    roles                   => $roles,
    salt                    => $salt,
    shell                   => $shell,
    system                  => $system,
    uid                     => $uid,
  }

  manageonce { "manageonce: User[${title}]":
    resourcetype  => 'user',
    resourcetitle => $name,
    parameters    => $params,
    onlyonce      => $onlyonce,
  }

}
