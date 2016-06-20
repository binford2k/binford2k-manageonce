# manageonce

#### Table of Contents

1. [Overview](#overview)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

I'll bet that at one time or another, you've wanted the ability to manage certain
resources on a node--but only once. For example, you may want to manage user
accounts with a defined initial password, but give your users the ability to
update their password.


## Usage

It's very simple. Just add the word `manageonce` before your resource declaration
and it will only be managed one time. This will currently work for `file` and
`user` resource types only.

```puppet
manageonce::file { '/root/.bashrc':
  owner   => 'root',
  group   => 'root,
  mode    => '0644,
  content => file('mymod/bashrc'),
}
```

Alternatively, you can declare any resource type by using the `manageonce` type:

```puppet
manageonce { "puppet master host entry":
  resourcetype  => 'host',
  resourcetitle => 'master.puppetlabs.vm',
  parameters    => { 'ip => 172.16.196.157', 'aliases' => ['puppet, master'] }
}

```

Finally, if you'd like to continue managing the resource, except for a certain
parameter or two, then you can pass an array of parameter names as `$onlyonce`.
Any parameters in that list will be managed one time only.

```puppet
manageonce::user { 'joe':
  ensure   => present,
  password => hiera('defaults::user::initialpassword'),
  onlyonce => ['password'],
}
```


## Limitations

This will currently only run on Unix-like platforms due to the hard-coded path
for the external `facts.d` directory.


## Disclaimer

I take no liability for the use of this module. As this uses standard Ruby, the
only reason that it won't work anywhere Puppet itself does is that it's got a
hard-coded path. (TODO: fix this!)

I have not yet validated on anything other than CentOS.


Contact
-------

binford2k@gmail.com
