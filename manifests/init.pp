# == Define: manageonce
#
# This defined type allows you to manage a resource one time only.
# For example, you may need to write out a file during provisioning,
# but need to be able to change the content of the file later on.
# Or maybe you want to create a user with a known initial password,
# but would like to be able to update the password.
#
# === Parameters
#
# Document parameters here.
#
# [*resourcetype*]
#   The string representation of the Puppet type you want to manage.
#
# [*resourcetitle*]
#   The title of the resource type you want to manage.
#
# [*parameters*]
#   A hash of parameters to pass to the resource type. This should be in
#   the same formate as you'd pass to `create_resources()`.
#
#
# === Examples
#
# manageonce { 'a thing':
#   resourcetype  => 'file',
#   resourcetitle => '/tmp/a_thing',
#   parameters    => {
#     owner       => 'root',
#     group       => 'root',
#     mode        => '0644',
#     content     => 'bloobleoobleoo',
#   }
# }
#
define manageonce (
  $resourcetype,
  $resourcetitle,
  $parameters = undef,
  $onlyonce   = undef,
) {
  require manageonce::setup

  # ugh, it would be nice to have some sort of exception handling now that datatypes are strict
  if defined('$manageonce') and $manageonce[$resourcetype] and $manageonce[$resourcetype][$resourcetitle] {

    if $onlyonce {
      validate_array($onlyonce)
      debug("Resource ${resourcetype}[${resourcetitle}] is no longer managing ${onlyonce} parameters.")
      create_resources($resourcetype, { $resourcetitle => delete($parameters, $onlyonce) })
    }
    else {
      $timestamp = $manageonce[$resourcetype][$resourcetitle]['timestamp']
      debug("Resource ${resourcetype}[${resourcetitle}] was last managed at ${timestamp}.")
    }
  }
  else {
    create_resources($resourcetype, { $resourcetitle => $parameters })

    exec { "${manageonce::setup::path}/record_resource.rb $resourcetype $resourcetitle": }
  }

}
